class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email_address
      t.string :name

      t.timestamps
    end
  end
end
