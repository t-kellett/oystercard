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
    expect { subject.top_up(subject.limit+1) }.to raise_error "You cannot top_up over the limit of #{subject.limit}"
  end
end
