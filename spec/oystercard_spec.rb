require 'oystercard'

describe Oystercard do

  let(:paddington) { double("Paddington") }
  let(:baker_street) { double("Baker Street") }
  let(:journey) { double("journey", :entry_station => paddington, :exit_station => baker_street, :finished => true, :minimum_fare => 1, :penalty_fare => 6, :fare => 1) }
  let(:started_journey) { double("journey", :entry_station => paddington, :exit_station => nil, :finished => false, :minimum_fare => 1, :penalty_fare => 6, :fare => 6) }
  let(:finished_journey) { double("journey", :entry_station => nil, :exit_station => baker_street, :finished => false, :minimum_fare => 1, :penalty_fare => 6, :fare => 6) }

  before do
    allow(journey).to receive(:fare).and_return(1)
    allow(journey).to receive(:minimum_fare).and_return(1)
    allow(paddington).to receive(:zone).and_return(0)
    allow(baker_street).to receive(:zone).and_return(0)
  end

  it "defaults to a balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it "adds money to the card balance" do 
    subject.top_up(5)
    expect(subject.balance).to eq(5)
  end

  it 'prevents you from topping up beyond the maximum balance' do
    expect { subject.top_up(subject.limit + 1) }.to raise_error "You cannot top_up over the limit of £#{subject.limit}"
  end

  it "prevents you from touching in unless the card's balance has enough for the minimum fare" do
    expect { subject.touch_in(paddington) }.to raise_error "You need the minimum fare balance of £#{journey.minimum_fare} to touch in"
  end

  it "deducts the minimum fee on touch out" do
    subject.top_up(subject.limit)
    subject.touch_in(paddington)
    expect { subject.touch_out(baker_street) }.to change { subject.balance }.by(-journey.minimum_fare)
  end

  context "going on a journey" do
    before do
      subject.top_up(subject.limit)
      subject.touch_in(paddington)
    end

    it "touching in twice causes a penalty fare deduction" do
      expect { subject.touch_in(paddington) }.to change { subject.balance }.by(-journey.penalty_fare)
    end

    context "leaving the station" do
      before do
        subject.touch_out(baker_street)
      end

      it "charges penalty fare if you touch out twice" do
        expect { subject.touch_out(baker_street) }.to change { subject.balance }.by(-journey.penalty_fare)
      end
    end
  end
end
