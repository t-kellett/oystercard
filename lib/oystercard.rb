class Oystercard
  attr_reader :balance, :limit, :minimum_fare
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @limit = LIMIT
    @in_use = false
    @minimum_fare = MINIMUM_FARE
  end

  def top_up(amount)
    raise "You cannot top_up over the limit of £#{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def touch_in
    raise "Already in journey" if in_journey?
    raise "You need the minimum fare balance of £#{@minimum_fare} to touch in" if @balance < @minimum_fare
    @in_use = true
  end

  def touch_out
    raise "Not in journey" unless in_journey?
    deduct(@minimum_fare)
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end
end