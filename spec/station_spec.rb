require 'station'

describe Station do

  subject(:station) { described_class.new(:name, :zone) }

  it "exposes the station name" do
    expect(station.name).to eq :name
  end

  it "exposes the station zone" do
    expect(station.zone).to eq :zone
  end

end
