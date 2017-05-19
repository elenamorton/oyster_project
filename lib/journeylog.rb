require_relative 'journey'
require_relative 'station'

class JourneyLog

  def initialize(journey_class: )
    @journeys = []
    @journey = journey_class:.new
  end

  def start_journey(station)
    @journey[:entry_station] = station
  end

  def finish_journey(station)
    @journey[:exit_station] = station
    self
  end

  def fare_charged
    @journey.fare
  end

  def add_journey(journey)
    @journeys.push(@journey)
  end

  def journeys
    @journeys.dup
  end

private
  attr_reader :journeys

  def current_journey
    @journey ||= journey_class.new
  end

  #def in_journey?
  #  @journey.started?
  #end

end
