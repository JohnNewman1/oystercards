require 'journey_log'

describe JourneyLog do
  let(:journey) {double(:journey, entry_station: :bank, exit_station: nil,)}
  let(:journey_class) {double(:journey_class, new: journey)}
  let(:station) {double(:station, name: :bank)}
  subject { described_class.new(journey_class) }


  describe  '#journeys' do
    it 'should have a collection that is empty on initialize' do
      expect(subject.journeys).to eq []
    end

    it 'records a journey' do
  allow(journey_class).to receive(:new).and_return journey
  allow(journey).to receive(:start)
  allow(journey).to receive(:finish)
  subject.start(station)
  subject.finish(station)
  expect(subject.journeys).to include journey
end
  end

  describe '#start' do
    it 'starts a journey' do
      allow(journey).to receive(:start)
      expect(subject).to respond_to(:start).with(1).argument
    end
  end

  describe '#finish' do
    it 'starts a journey' do
      allow(journey).to receive(:finish)
      expect(subject).to respond_to(:finish).with(1).argument
    end
  end

end
