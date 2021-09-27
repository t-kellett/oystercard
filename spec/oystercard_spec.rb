require 'Oystercard'

describe Oystercard do

  let(:paddington) { double("Paddington") }

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

  context "touching in and out" do
    before do
      subject.top_up(5)
    end
    
    it "lets you touch in" do
      subject.touch_in(paddington)

      expect(subject.in_journey?).to be(true)
    end

    it "lets you touch out" do
      subject.touch_in(paddington)
      subject.touch_out
      
      expect(subject.in_journey?).to be(false)
    end

    it "can't touch out when not in journey" do
      expect{ subject.touch_out }.to raise_error "Not in journey"
    end

    it "can't touch in when in journey" do
      subject.touch_in(paddington)
      expect{ subject.touch_in(paddington) }.to raise_error "Already in journey"
    end

    it "deducts the minimum fee on touch out" do
      subject.touch_in(paddington)
      
      expect { subject.touch_out }.to change{ subject.balance }.by(-subject.minimum_fare)
    end

    it "remembers the entry station after touch in" do
      subject.touch_in(paddington)
  
      expect(subject.entry_station).to eq(paddington)
    end

    it "forgets the entry station on touch out" do
      subject.touch_in(paddington)
      subject.touch_out

      expect(subject.entry_station).to be(nil)
    end
  end

  it "prevents you from touching in unless the card's balance has enough for the minimum fare" do
    expect {subject.touch_in(paddington)}. to raise_error "You need the minimum fare balance of £#{subject.minimum_fare} to touch in"
  end
end
