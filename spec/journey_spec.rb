require 'journey'

describe Journey do
  let(:incomplete_journey) { Journey.new("paddington") }
  let(:journey) { Journey.new("paddington", "marble_arch") }

  # it "knows if the journey is complete" do
  #   expect(incomplete_journey.complete?).to be(false)
  # end

  # it "calculates the fare of a complete journey" do
  #   journey.finish('london_bridge')
  #   expect(journey.fare).to eq(journey.minimum_fare)
  # end

  # it "calculates the fare of an incomplete journey" do
  #   expect(incomplete_journey.fare).to eq(incomplete_journey.penalty_fare)
  # end
end