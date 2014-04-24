class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password_digest

      t.timestamps
    end
    add_index :admin_users, :email
    add_index :admin_users, :username, unique: true
  end
end
