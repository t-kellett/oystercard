class JourneyLog
  attr_reader :journey, :exit_station, :journeys

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey = @journey_class.new()
    @journeys = []
  end

  def start(station = nil)
    @journey = @journey_class.new(station)

  end

  def finish(exit_station = nil)
    @journey.exit_station = exit_station
    @journeys << @journey.freeze
  end

  private
  def current_journey
    @journey.complete? ? @journey = journey_class.new : @journey
  end

end