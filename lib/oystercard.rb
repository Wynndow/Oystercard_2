require_relative 'journey'

class Oystercard

  MAX_LIMIT = 90

  attr_reader :balance, :journey

  def initialize (journey = Journey.new)
    @balance = 0
    @journey = journey

  end

  def top_up(amount)
    raise("Maximum balance of £#{MAX_LIMIT} reached") if over_limit?(amount)
    @balance += amount
  end


  def in_journey?
    journey.in_journey?
  end

  def touch_in(entry_station)
    raise("Cannot touch in: insufficient funds") if insufficient_funds?
    journey.touch_in(entry_station)
    deduct(journey.fare)
  end

  def touch_out(exit_station)
    journey.touch_out(exit_station)
    deduct(journey.fare)
  end

private

  def deduct(amount)
    @balance -= amount
  end

  def over_limit?(amount)
    (@balance + amount) > MAX_LIMIT
  end

  def insufficient_funds?
    balance < journey.min_fare
  end

end
