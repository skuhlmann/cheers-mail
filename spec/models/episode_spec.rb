require 'rails_helper'

RSpec.describe Episode, :type => :model do

  let(:episode) {Epsisode.create(series_title: "Cheers", number: 3, summary: "The Cheers gang decides to compete against the gang of a rival bar, Gary's Old Towne Tap, in bowling after suffering losing streaks against them in other sports.")}
end
