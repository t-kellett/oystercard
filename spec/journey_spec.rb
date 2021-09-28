require 'journey'

describe Journey do
  let(:incomplete_journey) { Journey.new("paddington") }
  let(:journey) { Journey.new("paddington", "marble_arch") }

  it "starts a journey" do
    expect(incomplete_journey.entry_station).to eq("paddington")
  end

  it "knows if the journey is complete" do
    expect(incomplete_journey.complete?).to be(false)
  end

  it "finishes a journey" do
    expect(journey.finish).to be(journey)
  end

  it "calculates the fare of a complete journey" do
    journey.complete_journey = true
    expect(journey.fare).to eq(journey.minimum_fare)
  end

  it "calculates the fare of an incomplete journey" do
    expect(incomplete_journey.fare).to eq(incomplete_journey.penalty_fare)
  end
end