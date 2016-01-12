class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  attr :current_journey, :journey_log

  def initialize(entry_station)
    @current_journey = {entry_station: entry_station}
  end

  def in_journey?
      current_journey.length == 1
  end
  #
  # def touch_in(entry_station)
  #   if in_journey?
  #     @journey_log << current_journey
  #     @current_journey = {}
  #   end
  #   @current_journey[:entry_station] = entry_station
  # end

  def touch_out(exit_station)
    @current_journey[:exit_station] = exit_station
  end

  def fare
    total = 0
    unless @journey_log.empty?
      total += (PENALTY_FARE + MIN_FARE) if journey_log[-1][:exit_station] == nil # No touch out last journey (applies on touch in)
      total += PENALTY_FARE if journey_log[-1][:entry_station] == nil # No touch in on current journey (applies on touch out)
    end
    total += MIN_FARE if  @current_journey.empty? #Applies on touch out (current journey has just been logged.)
    return total
  end

  def min_fare
    MIN_FARE
  end

end
