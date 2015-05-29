class Episode < ActiveRecord::Base
  belongs_to :series

  def self.build_episodes(name, seasons, series_id, single_page)
    wiki = WikiService.new
    if single_page.nil?
      1.upto(seasons) do |season|
        title = "#{name}_(season_#{season})"
        assemble_episodes(wiki, title, season, series_id)
      end
    else
      title = "List_of_#{name}_episodes"
      assemble_episodes(wiki, title, "Undetermined", series_id)
    end
  end

  def self.assemble_episodes(wiki, title, season, series_id)
    descriptions = wiki.collect_page_episodes(title)
    descriptions.each do |description|
      build_from_wikipedia(description, season, series_id)
    end
  end

  def self.build_from_wikipedia(description, season, series_id)
    create! do |episode|
      episode.summary = description
      episode.season = season
      episode.series_id = series_id
      if season == "Undetermined" then episode.single_page = true end
    end
  end
end