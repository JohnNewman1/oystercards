class Oystercard
  LIMIT_AMOUNT = 90
  MINIMUM_AMOUNT = 1
  JOURNEY_COST = 1
  attr_reader :balance,  :exit_station, :entry_station, :journey_log

  def initialize
    @balance = 0
    @journey_log = []
  end

  def top_up(amount)
    raise "Exceeded maximum amount #{LIMIT_AMOUNT}" if exceed_limit?(amount)
    @balance += amount
  end

  def exceed_limit?(amount)
    @balance + amount > LIMIT_AMOUNT
  end

  def in_journey?
    !!entry_station
    # is the same as @entry_station != nil
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_AMOUNT
    @entry_station = station.name
  end

  def touch_out(station)
    deduct(JOURNEY_COST)
    @exit_station = station.name
    @journey_log << { start: @entry_station, end: @exit_station}
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
