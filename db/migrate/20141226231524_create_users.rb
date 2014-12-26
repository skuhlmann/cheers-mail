class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_address
      t.boolean :admin

      t.timestamps
    end
  end
end
