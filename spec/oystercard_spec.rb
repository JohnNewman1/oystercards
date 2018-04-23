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

    it 'raises error if balance exceeds limit amount' do
      expect { subject.top_up(Oystercard::LIMIT_AMOUNT + 1) }.to raise_error "Exceeded maximum amount #{Oystercard::LIMIT_AMOUNT}"
    end
  end
end
