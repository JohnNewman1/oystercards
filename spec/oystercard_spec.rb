require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'should have a default balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should update balance to 10' do
      expect { subject.top_up(10) }.to change { subject.balance }.by 10
    end
  end
end
