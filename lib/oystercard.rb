class Oystercard
  attr_reader :balance, :limit
  LIMIT = 90

  def initialize
    @balance = 0
    @limit = LIMIT
    @in_use = false
  end

  def top_up(amount)
    raise "You cannot top_up over the limit of #{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Already in journey" if in_journey?
    @in_use = true
  end

  def touch_out
    raise "Not in journey" unless in_journey?
    @in_use = false
  end

  def in_journey?
    @in_use
  end
end