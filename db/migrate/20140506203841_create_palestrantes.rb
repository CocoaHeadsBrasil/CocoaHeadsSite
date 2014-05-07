class CreatePalestrantes < ActiveRecord::Migration
  def change
    create_table :palestrantes do |t|
      t.string :nome
      t.string :email
      t.string :website
      t.string :twitter
      t.string :github
      t.string :linkedin
      t.boolean :published

      t.timestamps
    end
  end
end
