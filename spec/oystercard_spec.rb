require 'oystercard.rb'

describe Oystercard do

  subject(:oyster) {described_class.new}
  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}

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

  end

  describe 'journey' do

    it 'initially not in a journey' do
      expect(oyster).not_to be_in_journey
    end

    describe '#touch_in' do

      it 'card responds to touch in method' do
        expect(oyster).to respond_to(:touch_in).with(1).argument
      end
      it 'changes in_journey status to true' do
        oyster.top_up(min_fare)
        oyster.touch_in(entry_station)
        expect(oyster).to be_in_journey
      end
      it 'raises error it balance is less than mimimum fare' do
        message = "Cannot touch in: insufficient funds"
        expect{oyster.touch_in(entry_station)}.to raise_error(message)
      end


    end

    describe '#touch_out' do
      before do
        oyster.top_up(min_fare)
        oyster.touch_in(entry_station)
      end

      it 'changes in_journey status from true to false' do
        oyster.touch_out(exit_station)
        expect(oyster).not_to be_in_journey
      end
      it 'charges min fare' do
        expect{oyster.touch_out(exit_station)}.to change{oyster.balance}.by(-min_fare)
      end

    end



  end

end
