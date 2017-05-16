require_relative 'station'

class OysterCard
  attr_reader :balance, :entry_station, :list_of_journeys

  BALANCE_DEFAULT = 5
  BALANCE_MAX = 90
  BALANCE_MIN = 1

  def initialize(balance = BALANCE_DEFAULT)
    @balance = balance
    @touch_in = false
    @touch_out = false
    @entry_station = nil
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
    @list_of_journeys.push({entry_station: station})
    @entry_station = station
  end

  def touch_out(station)
    @balance -= BALANCE_MIN
    @entry_station = nil
    @list_of_journeys.last[:exit_station] = station
  end

  def in_journey?
    @entry_station ? true : false
  end

end
