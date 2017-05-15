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

  it "limits the top up to a maximum value" do
    expect { oystercard.top_up(OysterCard::BALANCE_MAX) }.to raise_error "You've exceeded the maximum top up of #{OysterCard::BALANCE_MAX}"
  end

  it "deducts fare from balance" do
    oystercard1 = OysterCard.new(5)
    expect(oystercard1.deduct(3)).to eq 2
  end

  it "doesn't allow fare larger than the current balance" do
    oystercard1 = OysterCard.new(5)
    expect { oystercard1.deduct(8) }.to raise_error "You don't have enough money to travel."
  end

end
