class Oystercard

  MAX_LIMIT = 90
  MIN_FARE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise("Maximum balance of £#{MAX_LIMIT} reached") if over_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise("Cannot touch in: insufficient funds") if insufficient_funds?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

private

  def over_limit?(amount)
    (@balance + amount) > MAX_LIMIT
  end

  def insufficient_funds?
    balance < MIN_FARE
  end

end
