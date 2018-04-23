class Oystercard
  LIMIT_AMOUNT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Exceeded maximum amount #{LIMIT_AMOUNT}" if exceed_limit?(amount)
    @balance += amount
  end

  def exceed_limit?(amount)
    @balance + amount > LIMIT_AMOUNT
  end
end
