class AddImageProcessedToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :image_processed, :boolean
  end
end
