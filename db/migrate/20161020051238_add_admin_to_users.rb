class AddAdminToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :admin, :boolean
    add_column :admin_users, :user, :boolean
    add_column :admin_users, :group, :boolean
  end
end
