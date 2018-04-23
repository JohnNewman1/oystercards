class Oystercard
  LIMIT_AMOUNT = 90
  MINIMUM_AMOUNT = 1
  attr_reader :balance, :status

  def initialize
    @balance = 0
    @status = false
  end

  def top_up(amount)
    raise "Exceeded maximum amount #{LIMIT_AMOUNT}" if exceed_limit?(amount)
    @balance += amount
  end

  def exceed_limit?(amount)
    @balance + amount > LIMIT_AMOUNT
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @status
  end

  def touch_in
    raise "Insufficient funds" if @balance < MINIMUM_AMOUNT
    @status = true
  end

  def touch_out
    @status = false
  end
end
