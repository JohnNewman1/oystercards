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

  describe '#deduct' do
    it 'should update the balance by -10' do
      subject.top_up(20)
      expect(subject.deduct(10)).to eq 10
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
      subject.touch_in
      expect(subject.in_journey?).to be true
    end

    it 'should raises an error if balance is less than minimum amount' do
      expect { subject.touch_in }.to raise_error "Insufficient funds"
    end
  end

  describe '#touch_out' do
    it 'should return in_journey to be false when user touches out' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to be false
    end
  end

end
