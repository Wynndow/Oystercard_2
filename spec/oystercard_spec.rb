require 'oystercard.rb'

describe Oystercard do

  subject(:oyster) {described_class.new}
  max_bal = Oystercard::MAX_LIMIT
  min_fare = Oystercard::MIN_FARE

  describe 'Balance' do

    it 'has a starting balance of 0' do
      expect(oyster.balance).to eq(0)
    end

    describe '#top_up' do

      it 'is able to be topped up' do
        expect{oyster.top_up(10)}.to change{oyster.balance}.by(10)
      end
      it 'has a maximum balance limit of 90 pounds' do
        error = "Maximum balance of £#{max_bal} reached"
        oyster.top_up(max_bal)
        expect{oyster.top_up(1)}.to raise_error(error)
      end

    end

    describe '#deduct' do

      it 'removes the minimum fare from the balance' do
        oyster.top_up(max_bal)
        expect{oyster.deduct(min_fare)}.to change{oyster.balance}.by(-min_fare)
      end

    end

  end

  describe 'journey' do

    it 'initially not in a journey' do
      expect(oyster).not_to be_in_journey
    end

    describe '#touch_in' do

      it 'card responds to touch in method' do
        expect(oyster).to respond_to(:touch_in)
      end
      it 'changes in_journey status to true' do
        oyster.touch_in
        expect(oyster).to be_in_journey
      end

    end

    describe '#touch_out' do

      it 'changes in_journey status from true to false' do
        oyster.touch_in
        oyster.touch_out
        expect(oyster).not_to be_in_journey
      end
    end

  end

end
