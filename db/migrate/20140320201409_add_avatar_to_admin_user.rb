class AddAvatarToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :avatar, :string
  end
end