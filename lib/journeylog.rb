class JourneyLog

  def initialize
    @journey_log = []
  end

  def start_journey(entry_station)
    @journey_log << Journey.new(entry_station)
  end

  def end_journey(exit_station)
    @journey_log.last.touch_out(exit_station)
  end

  def fare

  end

end
