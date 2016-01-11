class Oystercard

  MAX_LIMIT = 90
  MIN_FARE = 1

  attr_reader :balance, :current_journey, :journey_log

  def initialize
    @balance = 0
    @current_journey = {}
    @journey_log = []
  end

  def top_up(amount)
    raise("Maximum balance of £#{MAX_LIMIT} reached") if over_limit?(amount)
    @balance += amount
  end


  def in_journey?
    current_journey.length == 1
  end

  def touch_in(entry_station)
    raise("Cannot touch in: insufficient funds") if insufficient_funds?
    @current_journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @current_journey[:exit_station] = exit_station
    @journey_log << current_journey
    @current_journey = {}
  end

private

  def deduct(amount)
    @balance -= amount
  end

  def over_limit?(amount)
    (@balance + amount) > MAX_LIMIT
  end

  def insufficient_funds?
    balance < MIN_FARE
  end

end
