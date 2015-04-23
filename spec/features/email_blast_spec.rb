require 'rails_helper'

describe "the email blast", type: :feature do

  it "sends a weekly email to all current subscribers" do
    series = Series.create(name: "cheers", seasons: 1)
    episode = Episode.create(summary: "lorem ipsum", season: 1)
    series.episodes << episode
    sub_1 = Subscription.create(email_address: "sam@example.com", name: "sam")
    sub_2 = Subscription.create(email_address: "deke@example.com", name: "deke")
    sub_1.series << series
    sub_2.series << series
    sub_1.save
    sub_2.save

    Subscription.weekly_blast

    results = ActionMailer::Base.deliveries

    expect(results).to_not be_nil
    expect(results.count).to eq(2)
    expect(results.last.to).to eq(["deke@example.com"])
    expect(results.last.to).to eq(["deke@example.com"])
    expect(results.last.body).to include("lorem ipsum")
  end
end


