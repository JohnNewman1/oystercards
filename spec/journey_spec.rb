require 'Journey'

describe Journey do

  let(:station) { double(:station, name: :liverpool_street) }
  let(:station2) { double :station, name: :London_Bridge }
  let(:card) { double(:card, balance: 10, deduct: nil) }

  describe '#in_journey?' do
    it "should let you know the status of user's journey" do
      expect(subject.in_journey?).to be false
    end
  end

  describe '#exit_station' do
    it 'remember the exit station on touch out' do
      subject.touch_in(station, card)
      subject.touch_out(station2, card)
      expect(subject.exit_station).to eq :London_Bridge
    end
  end

  describe '#touch_in' do
      let(:card_out) {double(:money2, balance: 0)}
    it 'should return in_journey to be true when user touches in' do
      subject.touch_in(station, card)
      expect(subject.in_journey?).to be true
    end

    it 'should raises an error if balance is less than minimum amount' do
      expect { subject.touch_in(station, card_out) }.to raise_error "Insufficient funds"
    end

    it 'should remember station after touch in' do
      subject.touch_in(station, card)
      expect(subject.entry_station).to eq station.name
    end
  end

  describe '#touch_out' do
    before(:each) do
      subject.touch_in(station, card)
      subject.touch_out(station2, card)
    end
    it 'should return in_journey to be false when user touches out' do
      expect(subject.in_journey?).to be false
    end

    it 'should make entry_station equal to nil on touch out' do
      expect(subject.entry_station).to be_nil
    end
  end

  describe '#journey_log' do
  it 'checks if it returns an empty array' do
    expect(subject.journey_log).to eq []
  end
  it 'checks if journey_list contains one journey' do
    subject.touch_in(station, card)
    subject.touch_out(station2, card)
    expect(subject.journey_log.size).to eq 1
  end
  it 'checks if journey_list contains a hash' do
    subject.touch_in(station, card)
    subject.touch_out(station2, card)
    expect(subject.journey_log).to eq [{:start=>:liverpool_street, :end=>:London_Bridge}]
  end
end

end
