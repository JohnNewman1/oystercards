require 'oystercard'

describe Oystercard do

  let(:station) { double(:station, name: :liverpool_street) }
  let(:station2) { double :station, name: :London_Bridge }

  describe '#balance' do
    it 'should have a default balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should update balance to 10' do
      expect { subject.top_up(10) }.to change { subject.balance }.by 10
    end

    it 'raises error if balance exceeds limit amount' do
      expect { subject.top_up(Oystercard::LIMIT_AMOUNT + 1) }.to raise_error "Exceeded maximum amount #{Oystercard::LIMIT_AMOUNT}"
    end
  end

  describe '#in_journey?' do
    it "should let you know the status of user's journey" do
      expect(subject.in_journey?).to be false
    end
  end

  describe '#touch_in' do
    it 'should return in_journey to be true when user touches in' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end

    it 'should raises an error if balance is less than minimum amount' do
      expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
    end

    it 'responds to one argument' do
     expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it 'should remember station after touch in' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station.name
    end
  end

  describe '#touch_out' do
    it 'should return in_journey to be false when user touches out' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.in_journey?).to be false
    end

    it 'should deduct journey cost from balance when user touches out' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(station)
      expect { subject.touch_out(station2) }.to change{ subject.balance }.by -Oystercard::JOURNEY_COST
    end

    it 'should make entry_station equal to nil on touch out' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.entry_station).to be_nil
    end
  end

  describe '#journey_log' do
  it 'checks if it returns an empty array' do
    expect(subject.journey_log).to eq []
  end
  it 'checks if journey_list contains one journey' do
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.journey_log.size).to eq 1
  end
  it 'checks if journey_list contains a hash' do
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.journey_log).to eq [{:start=>:liverpool_street, :end=>:London_Bridge}]
  end
end

describe '#exit_station' do
  it 'remember the exit station on touch out' do
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.exit_station).to eq :London_Bridge
  end
end

end
