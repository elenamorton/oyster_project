require_relative 'station'
require_relative 'journey'

class OysterCard
  attr_reader :balance, :entry_station, :list_of_journeys

  BALANCE_DEFAULT = 5
  BALANCE_MAX = 90
  BALANCE_MIN = 1

  def initialize(balance = BALANCE_DEFAULT)
    @balance = balance
    @journey = Journey.new
    @list_of_journeys = []
  end

  def top_up(value)
    raise "You've exceeded the maximum top up of #{BALANCE_MAX}" if @balance + value >= BALANCE_MAX
    @balance += value
  end

  def deduct(value)
    raise "You don't have enough money to travel." if @balance - value <= 0
    @balance -= value
  end

  def touch_in(station)
    raise "You have less than minimum £#{BALANCE_MIN} balance" if @balance < BALANCE_MIN
    deduct(@journey.fare)
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey.finish(station)
    deduct(@journey.fare)
    @list_of_journeys << @journey
    @journey = Journey.new
  end

  def in_journey?
    @journey.started?
  end

end
