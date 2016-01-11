require 'station.rb'

describe Station do

  subject(:station) {described_class.new({name: 'Aldgate', zone: 1})}

  describe 'initialized' do

    it 'with a name' do
      expect(station.name).to eq("Aldgate")
    end
    it 'with a zone' do
      expect(station.zone).to eq(1)
    end

  end

end
