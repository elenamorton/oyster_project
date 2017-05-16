

class Journey

  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6
  MIN_FARE = 1
  DEFAULT_STATION = :aldgate


  def initialize(station = nil)
    @entry_station = station
    @exit_station = nil
  end

  def fare
    return MIN_FARE if started? && complete?
    return PENALTY_FARE if started? && !complete?
    0
  end

  def finish(station)
    @exit_station = station
    self
  end

  def complete?
    @entry_station && @exit_station
  end

  def started?
    @entry_station != nil
  end

end
