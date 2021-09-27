require 'Oystercard'

describe Oystercard do
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

  it "deducts specific amounts" do
    subject.top_up(5)
    subject.deduct(2)

    expect(subject.balance).to eq(3)
  end

  context "touching in and out" do
    before do
      subject.top_up(5)
    end
    
    it "lets you touch in" do
      subject.touch_in

      expect(subject.in_journey?).to be(true)
    end

    it "lets you touch out" do
      subject.touch_in
      subject.touch_out
      
      expect(subject.in_journey?).to be(false)
    end

    it "can't touch out when not in journey" do
      expect{ subject.touch_out }.to raise_error "Not in journey"
    end

    it "can't touch in when in journey" do
      subject.touch_in
      expect{ subject.touch_in }.to raise_error "Already in journey"
    end
  end

  it "prevents you from touching in unless the card's balance has enough for the minimum fare" do
    expect {subject.touch_in}. to raise_error "You need the minimum fare balance of £#{subject.minimum_fare} to touch in"
  end
end
