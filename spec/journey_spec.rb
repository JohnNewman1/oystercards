require 'journey'

describe Journey do

  let(:station) { double :station, name: :bank, zone: 6}

  describe '#start' do
    it 'entry station equals station name ' do
      subject.start(station)
      expect(subject.entry_station).to eq(station.name)
    end
  end

  describe '#finish' do
    it 'exit station equals station name' do
      subject.finish(station)
      expect(subject.exit_station).to eq(station.name)
    end
  end


  describe '#fare' do
    it 'expects fare to be 1 if journey is complete' do
      subject.start(station)
      subject.finish(station)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end

    it 'expects fare to be penalty if journey is incomplete' do
      subject.finish(station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'expects fare to be penalty if journey is incomplete part 2' do
      subject.start(station)
      subject.start(station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

end
