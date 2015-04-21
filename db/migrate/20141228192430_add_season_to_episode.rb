class AddSeasonToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :season, :string
  end
end
