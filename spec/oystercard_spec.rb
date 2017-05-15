require 'oystercard'

describe OysterCard do
   subject(:oystercard) { described_class.new }
   it { expect(oystercard).to respond_to :top_up }

  it "has a balance" do
    expect(oystercard.balance).to eq OysterCard::BALANCE_DEFAULT
  end

  it "tops up the balance with a value" do
    expect(oystercard.top_up(5)).to eq 5 + OysterCard::BALANCE_DEFAULT
  end

end
