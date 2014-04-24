class AddUsefullScoresToFaqs < ActiveRecord::Migration
  def change
    add_column :faqs, :useful_yes, :integer, :default => 0
    add_column :faqs, :useful_no, :integer, :default => 0
  end
end