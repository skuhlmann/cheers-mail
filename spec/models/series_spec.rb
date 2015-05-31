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

  it "destroys all of it's related episodes when it's detroyed" do
    series.save
    episode = Episode.create(summary: "lalala")
    series.episodes << episode

    expect(series.episodes.first).to eq(episode)
    expect(Episode.count).to eq(1)

    series.destroy

    expect(Episode.count).to eq(0)
  end
end
