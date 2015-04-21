class AddSeasonsToSeries < ActiveRecord::Migration
  def change
    add_column :series, :seasons, :integer
  end
end
