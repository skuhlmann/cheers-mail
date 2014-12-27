class AddDefaultAdminToUser < ActiveRecord::Migration
  def change
    change_column_default :users, :admin, false
  end
end
