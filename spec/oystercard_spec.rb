require 'oystercard.rb'

describe Oystercard do

  subject(:oyster) {described_class.new(journey)}
  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}
  let(:journey) {double(:journey, :min_fare => 1)}

  max_bal = Oystercard::MAX_LIMIT

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

    it 'calls on journey.in_journey?' do
      allow(journey).to receive(:in_journey?)
      oyster.in_journey?
      expect(journey).to have_received(:in_journey?)

    end

    describe '#touch_in' do

      it 'card responds to touch in method' do
        expect(oyster).to respond_to(:touch_in).with(1).argument
      end
      it 'calls journey.touch_in' do
        allow(journey).to receive(:touch_in)
        allow(journey).to receive(:fare).and_return(1)
        oyster.top_up(journey.min_fare)
        oyster.touch_in(entry_station)
        expect(journey).to have_received(:touch_in)
      end
      it 'raises error it balance is less than mimimum fare' do
        message = "Cannot touch in: insufficient funds"
        expect{oyster.touch_in(entry_station)}.to raise_error(message)
      end


    end

    describe '#touch_out' do
      before do
        allow(journey).to receive(:touch_in)
        allow(journey).to receive(:touch_out)
        allow(journey).to receive(:fare).and_return(1)
        oyster.top_up(journey.min_fare)
        oyster.touch_in(entry_station)
      end

      it 'calls journey.touch_out' do
        oyster.touch_out(exit_station)
        expect(journey).to have_received(:touch_out)
      end
      it 'charges min fare' do
        expect{oyster.touch_out(exit_station)}.to change{oyster.balance}.by(-journey.min_fare)
      end

    end



  end

end
