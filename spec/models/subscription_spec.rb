require 'rails_helper'

RSpec.describe Subscription, :type => :model do

  let(:subscription) {Subscription.new(email_address: 'colleen@email.com', name: "Colleen")}

  it "is invalid without an email address" do
    subscription.email_address = nil
    expect(subscription).to_not be_valid
  end

  it "is invalid without a name" do
    subscription.name = nil
    expect(subscription).to_not be_valid
  end

  it "cannot have a duplicate email address" do
    subscription.save
    second_subscription = Subscription.create(email_address: 'colleen@email.com', name: "Coll")

    expect(second_subscription).not_to be_valid
  end

  it "return the most recent 3 subscriptions" do
    first = Subscription.create(email_address: 'sam@email.com', name: "Sam")
    second = Subscription.create(email_address: 'joe@email.com', name: "Joe")
    third = Subscription.create(email_address: 'jim@email.com', name: "Jim")
    fourth = Subscription.create(email_address: 'coll@email.com', name: "Coll")

    recent = Subscription.recent
    expect(recent.count).to eq(3)
    expect(recent[2]).to eq(fourth)
  end
end
