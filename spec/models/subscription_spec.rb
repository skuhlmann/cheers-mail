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

  it "is invalid with a bad email address" do
    subscription.email_address = "sam"
    expect(subscription).to_not be_valid

    subscription.email_address = "sam.com"
    expect(subscription).to_not be_valid

    subscription.email_address = "@gmail"
    expect(subscription).to_not be_valid
  end

  it "returns a random episode from it's series" do
    subscription = Subscription.create(email_address: 'sam@email.com', name: "Sam")
    series = Series.create(name: "seinfeld", seasons: 2)
    series_2 = Series.create(name: "cheers", seasons: 1)
    subscription.series << series
    subscription.series << series_2
    subscription.save
    50.times do
      series.episodes << Episode.create(summary: Faker::Lorem.sentence, season: 2)
      series_2.episodes << Episode.create(summary: Faker::Lorem.sentence, season: 1)
    end

    randoms = []
    5.times do
      randoms << subscription.random_episode
    end

    expect(randoms.uniq.count).to eq(5)
    expect(randoms.first.class).to eq(Episode)
    expect(randoms.first.series.subscriptions).to include(subscription)
  end
end
