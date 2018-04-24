require 'station'

describe Station do

  describe '#initialize' do
    it 'must make its name on initialization' do
      station = Station.new :Bank
      expect(station.name).to eq :Bank
    end
    it 'must make its zone on initialization' do
      station = Station.new :Bank
      station.zone = 1
      expect(station.zone).to eq 1
    end
  end

end
