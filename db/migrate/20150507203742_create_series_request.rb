class CreateSeriesRequest < ActiveRecord::Migration
  def change
    create_table :series_requests do |t|
      t.string :name
      t.belongs_to :subscription
      t.boolean :fulfilled, default: false

      t.timestamps
    end
  end
end
