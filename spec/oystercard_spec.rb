require 'Oystercard'

describe Oystercard do
  it "defaults to a balance of 0" do
    expect(subject.balance).to eq(0)
  end
end
