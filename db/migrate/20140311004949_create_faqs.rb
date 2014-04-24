class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.references :faq_group

      t.integer :position
      t.boolean :published
      t.string :question
      t.string :answer

      t.timestamps
    end
    add_index :faqs, :position
    add_index :faqs, :published
  end
end
