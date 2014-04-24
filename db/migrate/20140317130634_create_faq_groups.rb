class CreateFaqGroups < ActiveRecord::Migration
  def change
    create_table :faq_groups do |t|
      t.string :title
      t.integer :position
      t.boolean :published

      t.timestamps
    end
    add_index :faq_groups, :position
    add_index :faq_groups, :published
  end
end
