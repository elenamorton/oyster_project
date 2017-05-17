require 'journey'


describe Journey do

  subject(:journey) { described_class.new }
  let(:station) { double :station, zone: 1 }

  it { expect(journey).to respond_to :finish }

  it "exposes the journey entry station" do
    journey.instance_variable_set("@entry_station", :waterloo)
    expect(journey.entry_station).to eq :waterloo
  end

  it "exposes the journey exit station" do
    journey.instance_variable_set("@exit_station", :paddington)
    expect(journey.exit_station).to eq :paddington
  end

  it "knows if a journey is not complete" do
    expect(journey).not_to be_complete
  end

  it "returns itself one exiting a journey" do
    expect(journey.finish(station)).to eq(subject)
  end

  context 'given an entry station' do
    subject(:journey) { described_class.new(station) }

    it "has an entry station" do
      expect(journey.entry_station).to eq station
    end

    it "returns a penalty fare if no exit station given" do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

  end

  context 'given an exit station' do
    subject(:journey) { described_class.new(station) }
    let(:other_station) { double :other_station }

    before do
      journey.finish(other_station)
    end

    it "calculates a fare" do
      expect(journey.fare).to eq Journey::MIN_FARE
    end

    it "knows a journey is complete" do
      expect(journey).to be_complete
    end
  end

end
