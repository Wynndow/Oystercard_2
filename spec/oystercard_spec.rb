require 'oystercard.rb'

describe Oystercard do

  subject(:oyster) {described_class.new}

  describe 'By default' do
    it 'has a starting balance of 0' do
      expect(oyster.balance).to eq(0)
    end
  end

end
