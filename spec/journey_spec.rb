require 'journey.rb'

describe Journey do
  subject(:journey) {described_class.new}
  let(:entry_station) {double(:entry_station)}
  let(:exit_station) {double(:exit_station)}

  describe '#current_journey' do

    it 'records entry station' do
      journey.touch_in(entry_station)
      expect(journey.current_journey[:entry_station]).to eq(entry_station)
    end
    it 'resets current journey' do
      journey.touch_out(exit_station)
      expect(journey.current_journey).to eq({})
    end

  end

  describe '#journey_log' do

    it 'is empty by default' do
      expect(journey.journey_log).to be_empty
    end
    it 'stores a complete journey on touch out' do
      journey.touch_in(entry_station)
      journey.touch_out(exit_station)
      expect(journey.journey_log).to include({entry_station: entry_station,
                                             exit_station: exit_station})
    end

  end

end
