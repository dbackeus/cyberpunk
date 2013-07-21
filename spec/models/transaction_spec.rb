require 'spec_helper'

describe Transaction do
  it "affects characters money on creation" do
    character = create(:character, money: 2000)
    transaction = Transaction.create!(character: character, amount: 200)
    character.reload.money.should == 2200

    transaction = Transaction.create!(character: character, amount: -1200)
    character.reload.money.should == 1000
  end

  it "affects characters money on destruction" do
    character = create(:character, money: 2000)
    transaction = Transaction.create!(character: character, amount: 200)
    transaction.destroy
    character.reload.money.should == 2000

    transaction = Transaction.create!(character: character, amount: -1200)
    transaction.destroy
    character.reload.money.should == 2000
  end

  it "does not accept 0 as amount" do
    transaction = Transaction.new(amount: 0)
    transaction.valid?
    transaction.errors[:amount].should include("can't be zero")
  end
end
