class AddEmailToCidades < ActiveRecord::Migration
  def change
    add_column :cidades, :email, :string
  end
end
