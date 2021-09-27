require 'Oystercard'

describe Oystercard do

  let(:paddington) { double("Paddington") }
  let(:baker_street) { double("Baker Street")}

  it "defaults to a balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it "adds money to the card balance" do 
    subject.top_up(5)
    expect(subject.balance).to eq(5)
  end

  it 'prevents you from topping up beyond the maximum balance' do
    expect { subject.top_up(subject.limit+1) }.to raise_error "You cannot top_up over the limit of £#{subject.limit}"
  end

  it "has en empty list of journeys on creation" do
    expect(subject.journey_history).to be_empty
  end

  it "can't touch out when not in journey" do
    expect{ subject.touch_out(baker_street) }.to raise_error "Not in journey"
  end

  it "prevents you from touching in unless the card's balance has enough for the minimum fare" do
    expect {subject.touch_in(paddington)}. to raise_error "You need the minimum fare balance of £#{subject.minimum_fare} to touch in"
  end

  context "going on a journey" do
    before do
      subject.top_up(subject.limit)
      subject.touch_in(paddington)
    end
    
    it "lets you touch in" do
      expect(subject.in_journey?).to be(true)
    end

    it "can't touch in when in journey" do
      expect{ subject.touch_in(paddington) }.to raise_error "Already in journey"
    end

    it "deducts the minimum fee on touch out" do
      expect { subject.touch_out(baker_street) }.to change{ subject.balance }.by(-subject.minimum_fare)
    end

    it "remembers the entry station after touch in" do
      expect(subject.entry_station).to eq(paddington)
    end

    context "leaving the station" do
      before do
        subject.touch_out(baker_street)
      end

      it "lets you touch out" do
        expect(subject.in_journey?).to be(false)
      end

      it "forgets the entry station on touch out" do
        expect(subject.entry_station).to be(nil)
      end

      it "stores the list journeys" do 
        expect(subject.journey_history).to eq([{:entry_station => paddington, :exit_station => baker_street}])
      end
    end
  end
end
