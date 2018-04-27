# Oystercard class
require_relative 'journey_log.rb'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :history, :journeylog

  def initialize(journeylog = JourneyLog.new)
    @balance = 0
    @journeylog = journeylog
  end

  def top_up(amount)
    raise "maximim balance of £#{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'insufficient funds available' if balance < MINIMUM_BALANCE
    penalty_check
    @journeylog.start(station)
  end

  def touch_out(station)
    @journeylog.finish(station)
    deduct(@journeylog.current.fare)
    @journeylog.current = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end


  def penalty_check
    deduct(@journeylog.current.fare) if @journeylog.current
  end

end
