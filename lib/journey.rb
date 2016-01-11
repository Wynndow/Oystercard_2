class Journey

  attr :current_journey, :journey_log

  def initialize
    @current_journey = {}
    @journey_log = []
  end

  def in_journey?
      current_journey.length == 1
  end

  def touch_in(entry_station)
    @current_journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)

    @current_journey[:exit_station] = exit_station
    @journey_log << current_journey
    @current_journey = {}
  end

  private



end
