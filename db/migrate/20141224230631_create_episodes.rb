class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.text :summary
      t.string :series

      t.timestamps
    end
  end
end
