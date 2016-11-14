class AddManagerToAdminUser < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :manager, :boolean
  end
end
