class Oystercard
  attr_reader :balance, :limit, :journey_log
  LIMIT = 90

  def initialize(journey_log_class = JourneyLog)
    @balance = 0
    @limit = LIMIT
    @journey_log = journey_log_class.new
  end

  def top_up(amount)
    raise "You cannot top_up over the limit of £#{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def touch_in(entry_station)
    raise "You need the minimum fare balance of £#{@journey_log.journey.minimum_fare} to touch in" if @balance < @journey_log.journey.minimum_fare
    @journey_log.finish && deduct(last_journey.fare) if (!last_journey.entry_station.nil? && last_journey.exit_station.nil?)
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(last_journey.fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def last_journey
    @journey_log.journeys.empty? ? @journey_log.journey : @journey_log.journeys.last
  end
end
