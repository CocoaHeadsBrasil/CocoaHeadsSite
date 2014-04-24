class ChangeDefaultOnFaqs < ActiveRecord::Migration
	def up
		change_column :faqs, :published, :boolean, :default => false
	end

	def down
		change_column :faqs, :published, :boolean, :default => nil
	end
end
