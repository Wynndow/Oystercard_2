require './lib/journey.rb'
require './lib/oystercard.rb'
require './lib/station.rb'

describe 'Feature test' do
  let(:journey){ Journey.new }
  let(:oystercard){ Oystercard.new }
  let(:entry_station){ Station.new({name: 'Aldgate', zone: 1}) }
  let(:exit_station){ Station.new({name: 'Holborn', zone: 1}) }

  it 'charges normal fare for normal journey' do
    oystercard.top_up(20)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.balance).to eq(19)
  end

  it 'charges penalty fare & min fare for incomplete journey' do
    oystercard.top_up(20)
    oystercard.touch_in(entry_station)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.balance).to eq(12)
  end

  it 'charges penalty fare & min fare for incomplete journey' do
    oystercard.top_up(20)
    oystercard.touch_out(exit_station)
    expect(oystercard.balance).to eq(13)
  end

end
