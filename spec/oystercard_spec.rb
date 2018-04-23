require 'oystercard'

describe Oystercard do


  describe '#balance' do
    it 'should have a default balance of 0' do
      expect(subject.balance).to eq 0
    end
  end
end
