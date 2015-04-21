class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :name
    end

    remove_column :episodes, :series
  end
end
