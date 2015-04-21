class Episode < ActiveRecord::Base
  belongs_to :series

  def self.build_episodes(name, seasons, series_id)
    wiki = WikiService.new
    1.upto(seasons) do |season|
      title = "#{name}_(season_#{season})"
      descriptions = wiki.collect_data(title)
      descriptions.each do |description|
        build_from_wikipedia(description, season, series_id)
      end
    end
  end

  def self.build_from_wikipedia(description, season, series_id)
    create! do |episode|
      episode.summary = description
      episode.season = season
      episode.series_id = series_id
    end
  end
end
