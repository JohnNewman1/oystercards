require 'oystercard'

describe Oystercard do

  let(:entry_station) {double :station , name: :bank }
  let(:exit_station) {double :station , name: :bond_street }
  let(:hash) { {entry_station: entry_station.name, exit_station: exit_station.name,} }

  describe '#initialize' do

    it 'has balance of zero' do
      expect(subject.balance).to eq(0)
    end

    it 'it has a maximum balance' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up(1) }.to raise_error "maximim balance of £#{Oystercard::MAXIMUM_BALANCE} exceeded"
    end

    it 'has an empty list of journeys by default' do
      expect(subject.history).to be_empty
    end

  end

  describe '#top_up' do

    it 'tops up balance by 10' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

  end

  describe '#touch_in' do

    it 'does not let user touch in with 0 balance' do
      expect { subject.touch_in(entry_station) }.to raise_error 'insufficient funds available'
    end

    it 'does not deduct fare on first touch in' do
      subject.top_up(10)
      expect { subject.touch_in(entry_station) }.to change { subject.balance }.by(0)
    end

    it 'touch_in and touch_in creates one journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_in(entry_station)
      expect(subject.history.length).to eq 1
    end

    it 'touch_in and touch_in creates one journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_in(entry_station)
      expect(subject.history[0]).to eq({ entry_station: :bank, exit_station: nil })
    end

  end

  describe '#touch_out' do

    before(:each) do
      subject.top_up(5)
      subject.touch_in(entry_station)
    end

    it 'deducts minimum balance when touch_out is called' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Journey::MINIMUM_FARE)
    end

    it 'touch_in and touch_out creates one journey' do
      subject.touch_out(exit_station)
      expect(subject.history.length).to eq 1
    end

    it 'adds journey hash to history' do
      subject.touch_out(exit_station)
      expect(subject.history).to include(hash)
    end
  end

  describe 'check fare is correct tests' do
    it 'charges 6 when not touching out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect { subject.touch_in(entry_station) }.to change { subject.balance }.by(-Journey::PENALTY_FARE)
    end

    it 'charges 6 when not touching in' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Journey::PENALTY_FARE)
    end

    it 'touch_in and touch_in creates one journey' do
      subject.touch_out(exit_station)
      expect(subject.history[0]).to eq({ entry_station: nil, exit_station: :bond_street })
    end

  end

  describe '#history' do

    it 'touch_in, touch_in and touch_out creates two journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.history.length).to eq 2
    end

    it 'touch_out and touch_out creates two journey' do
      subject.top_up(10)
      subject.touch_out(exit_station)
      subject.touch_out(exit_station)
      expect(subject.history.length).to eq 2
    end

end

end
