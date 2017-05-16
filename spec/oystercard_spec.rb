require 'oystercard'

describe OysterCard do
   subject(:oystercard) { described_class.new }


   it { expect(oystercard).to respond_to :top_up }
   it { expect(oystercard).to respond_to :touch_in}

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

  it "raise error when balance is less than minimum amount on touch in" do
    oystercard1 = OysterCard.new(0)
    expect { oystercard1.touch_in(:station) }.to raise_error "You have less than minimum £#{OysterCard::BALANCE_MIN} balance"
  end

  it "deducts fare at touch out" do
    oystercard.touch_in(:entry_station)
    expect { oystercard.touch_out(:exit_station) }.to change{oystercard.balance}.by(-OysterCard::BALANCE_MIN)
  end

  it "checks if it is in journey" do
    oystercard.touch_in(:entry_station)
    expect(oystercard.in_journey?).to eq true
  end

  it "checks if it is not in journey" do
    oystercard.touch_in(:entry_station)
    oystercard.touch_out(:exit_station)
    expect(oystercard.in_journey?).to eq false
  end

  it "expects the card to remember the entry station after touch in" do
    oystercard.touch_in(:entry_station)
    expect(oystercard.entry_station).to eq :entry_station
  end

  it "expects card to store a journey" do
    entry_station =  double(:station)
    exit_station =  double(:station)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.list_of_journeys.last).to eq ({entry_station: entry_station, exit_station: exit_station})
  end

  it "expects crad to have an empty journeys list at start" do
    expect(oystercard.list_of_journeys).to eq []
  end

end
