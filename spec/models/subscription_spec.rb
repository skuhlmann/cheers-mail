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
end
