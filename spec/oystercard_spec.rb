require 'oystercard.rb'

describe Oystercard do

  subject(:oyster) {described_class.new}

  describe 'Balance' do

    it 'has a starting balance of 0' do
      expect(oyster.balance).to eq(0)
    end
    it 'is able to be topped up' do
      expect{oyster.top_up(10)}.to change{oyster.balance}.by(10)
    end
    it 'has a maximum balance limit of 90 pounds' do
      max_bal = Oystercard::MAX_LIMIT
      error = "Maximum balance of £#{max_bal} reached"
      oyster.top_up(max_bal)
      expect{oyster.top_up(1)}.to raise_error(error)
    end

  end

end
