class Oystercard
  attr_reader :balance, :limit, :minimum_fare, :entry_station, :exit_station, :journeys
  LIMIT = 90

  def initialize
    @balance = 0
    @limit = LIMIT
    @journeys = []
  end

  def top_up(amount)
    raise "You cannot top_up over the limit of £#{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def touch_in(entry_station, new_journey = Journey.new(entry_station))
    raise "You need the minimum fare balance of £#{new_journey.minimum_fare} to touch in" if @balance < new_journey.minimum_fare
    add_journey(new_journey)
    deduct(@journeys[-2].fare) && @journeys[-2].finish if @journeys.count > 1 && !@journeys[-2].finished #-2 as you just added a new journey that will always be unfinished

    # add a journey
    # deduct a penalty fare and end the previous journey if previous journey is unfinished and it is not the first journey
  end

  def touch_out(station, new_journey = Journey.new)
    @journeys.last.finished ? add_journey(new_journey.finish(station)) : @journeys.last.finish(station)
    deduct(@journeys.last.fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def add_journey(journey)
    @journeys << journey
  end
end