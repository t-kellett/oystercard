class Journey
  attr_reader :entry_station, :exit_station, :minimum_fare, :penalty_fare, :finished
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @minimum_fare = MINIMUM_FARE
    @penalty_fare = PENALTY_FARE
    @finished = false
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
    @finished = true
    self
  end

  def complete?
    @entry_station != nil && @exit_station != nil
  end

  def fare
    self.complete? && self.finished ? @minimum_fare : @penalty_fare
  end

end