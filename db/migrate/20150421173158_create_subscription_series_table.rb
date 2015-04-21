class CreateSubscriptionSeriesTable < ActiveRecord::Migration
  def change
    create_table :series_subscriptions do |t|
      t.belongs_to :subscription, index: true
      t.belongs_to :series, index: true

      t.timestamps
    end
  end
end
