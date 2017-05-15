class Oystercard

  attr_reader :balance
  BALANCE_DEFAULT = 0

  def initialize(balance = BALANCE_DEFAULT)
    @balance = balance
  end

  def top_up(value)
    @balance += value
  end

  
end
