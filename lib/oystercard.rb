class Oystercard
  attr_reader :balance, :limit
  LIMIT = 90

  def initialize
    @balance = 0
    @limit = LIMIT
  end

  def top_up(amount)
    raise "You cannot top_up over the limit of #{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end