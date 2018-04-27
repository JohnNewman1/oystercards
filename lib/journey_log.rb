require_relative 'journey.rb'

class JourneyLog

  attr_reader :journey
  attr_accessor :current

  def initialize(journey = Journey)
    @journey = journey
    @journeys = []
  end

  def start(station)
    @journeys << @current if @current != nil
    @current = @journey.new
    @current.start(station)
  end

  def finish(station)
    current_journey
    @current.finish(station)
    @journeys << @current
  end

  def journeys
    @journeys.dup
  end

private

  def current_journey
    @current ||= @journey.new
  end

end
