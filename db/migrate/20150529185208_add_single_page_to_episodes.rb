class AddSinglePageToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :single_page, :boolean, default: false
  end
end
