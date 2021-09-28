class Oystercard
  attr_reader :balance, :limit, :minimum_fare, :entry_station, :exit_station, :journey_history
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @limit = LIMIT
    @minimum_fare = MINIMUM_FARE
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(amount)
    raise "You cannot top_up over the limit of £#{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def touch_in(station)
    raise "Already in journey" if in_journey?
    raise "You need the minimum fare balance of £#{@minimum_fare} to touch in" if @balance < @minimum_fare
    @entry_station = station
  end

  def touch_out(station)
    raise "Not in journey" unless in_journey?
    deduct(@minimum_fare)
    @exit_station = station
    journey_history << {:entry_station => @entry_station, :exit_station => @exit_station}
    @entry_station = nil
    # @complete_journey = true unless oyster.entry_station.nil?
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end