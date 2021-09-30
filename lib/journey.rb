class Journey
  attr_reader :entry_station, :minimum_fare, :penalty_fare
  attr_accessor :exit_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @minimum_fare = MINIMUM_FARE
    @penalty_fare = PENALTY_FARE
  end

  def complete?
    !@entry_station.nil? && !@exit_station.nil?
  end

  def fare
    complete? ? (@minimum_fare + (entry_station.zone - exit_station.zone).abs) : @penalty_fare
  end
end
