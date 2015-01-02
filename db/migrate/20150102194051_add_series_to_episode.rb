class AddSeriesToEpisode < ActiveRecord::Migration
  def change
    add_reference :episodes, :series, index: true
  end
end
