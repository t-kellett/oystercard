require 'journey'

describe Journey do
  let(:incomplete_journey) { Journey.new("paddington") }
  let(:paddington) { double("paddington", :zone => 1) }
  let(:marble_arch) { double("marble_arch", :zone => 3) }
  let(:journey) { Journey.new(paddington, marble_arch) }

  before do
    allow(paddington).to receive(:zone).and_return(1)
    allow(marble_arch).to receive(:zone).and_return(3)
  end
  
  it "knows if the journey is complete" do
    expect(incomplete_journey.complete?).to be(false)
  end

  it "calculates the fare of a complete journey" do
    journey.exit_station = marble_arch
    expect(journey.fare).to eq(3)
  end

  it "calculates the fare of an incomplete journey" do
    expect(incomplete_journey.fare).to eq(incomplete_journey.penalty_fare)
  end
end
