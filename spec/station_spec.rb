require 'Station'

describe Station do
  it 'will allow you to make a name on initialization' do
    station = Station.new(:bank, 2)
    expect(station.name).to eq :bank
  end

  it 'will allow you to make a zone on initialization' do
    station = Station.new(:bank, 2)
    expect(station.zone).to eq 2
  end
end
