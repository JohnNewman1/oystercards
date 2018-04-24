require 'station'

describe Station do
  let(:name) {:bank}
  let(:zone) {1}

  subject { described_class.new(name, zone) }

  describe '#initialize' do
    it 'must make its name on initialization' do
      expect(subject.name).to eq :bank
    end
    it 'must make its zone on initialization' do
      expect(subject.zone).to eq 1
    end
  end

end
