class Oystercard

  MAX_LIMIT = 90
  MIN_FARE = 1

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise("Maximum balance of £#{MAX_LIMIT} reached") if over_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

private

  def over_limit?(amount)
    (@balance + amount) > MAX_LIMIT
  end

end
