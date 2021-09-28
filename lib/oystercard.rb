class Oystercard
  attr_reader :balance, :limit, :minimum_fare, :entry_station, :exit_station, :journey_history
  LIMIT = 90

  def initialize
    @balance = 0
    @limit = LIMIT
    @current_journey = nil
    @journey_history = []
  end

  def top_up(amount)
    raise "You cannot top_up over the limit of £#{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def touch_in(entry_station, new_journey = Journey.new(entry_station))
    raise "You need the minimum fare balance of £#{new_journey.minimum_fare} to touch in" if @balance < new_journey.minimum_fare
    #@journey_history.empty? ? @journey_history << (@current_journey = new_journey) : @current_journey = new_journey
    @journey_history.last.finished ? deduct(@journey_history.last.finish) : @journey_history.last.finish 
  end

  def touch_out(station, journey = Journey.new(station))
    @journey_history.last.finished ?  @journey_history << @current_journey.finish(station) : @journey_history << journey.finish
    deduct(@journey_history.last.fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end