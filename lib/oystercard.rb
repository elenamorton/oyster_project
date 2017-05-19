require_relative 'station'
# require_relative 'journey'
require_relative 'journeylog'

class OysterCard
  attr_reader :balance, :journeysLog

  BALANCE_DEFAULT = 10
  BALANCE_MAX = 90
  BALANCE_MIN = 1

  def initialize(balance = BALANCE_DEFAULT)
    @balance = balance
    @journeysLog = JourneysLog.new
  end

  def touch_in(station)
    raise "You have less than minimum £#{BALANCE_MIN} balance" if @balance < BALANCE_MIN
    deduct(@journeyLog.fare_charged)
    @journeyLog.start_journey(station)
  end

  def touch_out(station)
    @journeyLog.finish_journey(station)
    deduct(@journeyLog.fare_charged)
  end

  def journeysLog_reader
    @journeyLog.journeys.each_with_index do |journey, index|
      "Trip: #{{index}} started at: #{journey[:entry_station]} and finished at: #{journey[:exit_station]}\n"
    end
  end


private

  def top_up(value)
    raise "You've exceeded the maximum top up of #{BALANCE_MAX}" if @balance + value >= BALANCE_MAX
    @balance += value
  end

  def deduct(value)
    raise "You don't have enough money to travel." if @balance - value <= 0
    @balance -= value
  end

end
