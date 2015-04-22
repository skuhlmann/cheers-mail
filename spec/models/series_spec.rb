require 'rails_helper'

RSpec.describe Series, :type => :model do

  let(:series) {Series.create(name: "Cheers", seasons: 3)}

  it "cannot have a duplicate name" do
    series.save
    duplicate_series = Series.create(name: "Cheers", seasons: 11)

    expect(duplicate_series).to be_invalid
  end

  it "upcases the name before saving" do
    new_series = Series.create(name: "seinfeld", seasons: 2)
    another_series = Series.create(name: "who's the boss", seasons: 1)

    expect(new_series.name).to eq("Seinfeld")
    expect(another_series.name).to eq("Who's The Boss")
  end

  it "returns a random episode from its episodes" do
    series = Series.create(name: "seinfeld", seasons: 2)
    100.times do
      series.episodes << Episode.create(summary: Faker::Lorem.sentence, season: 2)
    end

    randoms = []
    4.times do
      randoms << series.random_episode
    end

    expect(randoms.first.class).to be(Episode)
    expect(randoms.uniq.count).to be(4)
  end
end
