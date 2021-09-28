class Oystercard
  attr_reader :balance, :limit, :minimum_fare, :entry_station, :exit_station, :journey_history
  LIMIT = 90

  def initialize
    @balance = 0
    @limit = LIMIT
    @journey_history = []
  end

  def top_up(amount)
    raise "You cannot top_up over the limit of £#{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def touch_in(entry_station, journey = Journey.new(entry_station))
    raise "You need the minimum fare balance of £#{journey.minimum_fare} to touch in" if @balance < journey.minimum_fare
    @journey_history.empty? ? journey_history << journey : @journey_history.last.finished = true
    deduct(@journey_history.last.fare) if (@journey_history.last.finished && !@journey_history.last.exit_station.nil?)
  end

  def touch_out(station, journey = Journey.new(station))
    @journey_history.empty? ? journey_history << journey : @journey_history.last.finished = true
    deduct(@journey_history.last.fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end