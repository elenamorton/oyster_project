require 'journeylog'

describe JourneyLog do

  let(:journey) { double :journey } #this needs to have some methods
  let(:station) { double :station }
  let(:journey_class) { double :journey_class, new: journey }
  subject(:journeyLog) { described_class.new(journey_class: journey_class) }

  describe '#start' do
    it 'allow to start a journey' do
      expect(journey_class).to receive(:new).with(entry_station: station)
      journeyLog.start(station)
    end



  end


end
