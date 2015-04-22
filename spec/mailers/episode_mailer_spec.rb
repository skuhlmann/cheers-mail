require "rails_helper"

RSpec.describe EpisodeMailer, :type => :mailer do

  it "can sends a episode summary message to subscribers" do
    subscriber = Subscription.new(email_address: "coll@example.com", name: "coll")
    series = Series.create(name: "cheers", seasons: 1)
    subscriber.series << series
    subscriber.save
    episode = Episode.create(summary: "lorem ipsum", season: 1)
    episode.series = series
    episode.save

    EpisodeMailer.weekly_episode_email(subscriber).deliver
    result = ActionMailer::Base.deliveries.last

    expect(result).not_to be_nil
    expect(result.to.first).to eq("coll@example.com")
    expect(result.subject).to eq("Do You Remember That One Episode of Cheers?")
    expect(result.body).to include("Cheers")
    expect(result.body).to include("coll")
    expect(result.body).to include("lorem ipsum")
  end
end
