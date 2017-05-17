require_relative 'journey'
require_relative 'station'

class JourneyLog

  attr_reader :list_of_journeys

  def initialize(journey_class: )
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)

  end

end
