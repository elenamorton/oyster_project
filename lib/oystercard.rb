class OysterCard
  attr_reader :balance, :in_journey
  BALANCE_DEFAULT = 5
  BALANCE_MAX = 90
  BALANCE_MIN = 1

  def initialize(balance = BALANCE_DEFAULT)
    @balance = balance
    @touch_in = false
    @touch_out = false
    @in_journey = false
  end

  def top_up(value)
    raise "You've exceeded the maximum top up of #{BALANCE_MAX}" if @balance + value >= BALANCE_MAX
    @balance += value
  end

  def deduct(value)
    raise "You don't have enough money to travel." if @balance - value <= 0
    @balance -= value
  end

  def touch_in
    raise "You have less than minimum £#{OysterCard::BALANCE_MIN} balance" if @balance < BALANCE_MIN
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
