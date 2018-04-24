class Journey
  JOURNEY_COST = 1
  MINIMUM_AMOUNT = 1
  attr_reader :balance,  :exit_station, :entry_station, :journey_log

  def initialize
    @journey_log = []
  end

  def in_journey?
    !!entry_station
    # is the same as @entry_station != nil
  end

  def touch_in(station, card)
    raise "Insufficient funds" if card.balance < MINIMUM_AMOUNT
    @entry_station = station.name
  end

  def touch_out(station, card)
    card.deduct(JOURNEY_COST)
    @exit_station = station.name
    add_to_log
    @entry_station = nil
  end

  private

  def add_to_log
    @journey_log << { start: @entry_station, end: @exit_station}
  end
end
