class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :permalink
      t.integer :position
      t.boolean :published
      t.integer :modified_by
      t.integer :created_by
      t.text :body

      t.timestamps
    end
    add_index :contents, :permalink, unique: true
    add_index :contents, :position
    add_index :contents, :modified_by
    add_index :contents, :created_by
  end
end
