require 'journey'

describe Journey do
  let(:journey) { Journey.new("Paddington") }
  it "starts a journey" do
    expect(journey.entry_station).to eq("Paddington")
  end

  it "knows if the journey is complete" do
    expect(journey.complete?).to be(false)
  end

  it "finishes a journey" do
    expect(journey.finish).to be(journey)
  end

  it "calculates the fare of a complete journey" do
    expect(journey.calculate_fare).to eq(journey.minimum_fare)
  end
end