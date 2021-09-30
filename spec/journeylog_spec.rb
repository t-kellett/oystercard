require "journeylog"

describe JourneyLog do
  let(:journey) { subject.start("Paddington") }

  it "starts a nil journey" do
    no_entry_journey = subject.start
    expect(no_entry_journey).to be_an_instance_of(Journey)
  end

  it "should create a new journey with entry station" do
    expect(journey.entry_station).to eq("Paddington")
  end

  it "finishing a journey adds an exit station to the current journey" do
    subject.finish("Baker_Street")
    expect(subject.journey.exit_station).to eq("Baker_Street")
  end

  context "adding to the journeys array" do
    before do
      subject.start("liverpool_st")
      subject.finish("aldgate_east")
    end

    it "journeys should return the journeys array" do
      expect(subject.journeys).to eq([subject.journey])
    end

    it "the journeys array should not be able to be externally changed" do
      expect { subject.journeys[0].exit_station = "royal_oak" }.to raise_error(FrozenError)
    end
  end
end
