require 'money'

describe Money do

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
      limit = Money::LIMIT_AMOUNT
      expect { subject.top_up(limit + 1) }.to raise_error "Exceeded maximum amount #{limit}"
    end
  end

  describe '#deduct' do
    it 'ruduces balance by argument' do
      subject.top_up(10)
      expect{subject.deduct(10)}.to change { subject.balance }.by -10
    end
  end

end
