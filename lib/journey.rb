class Journey
  attr_reader :entry_station, :minimum_fare
  MINIMUM_FARE = 1

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @complete_journey = false
    @minimum_fare = MINIMUM_FARE
  end

  def complete?
    @complete_journey
  end

  def finish
    self
  end

  def calculate_fare
    @minimum_fare
  end

end