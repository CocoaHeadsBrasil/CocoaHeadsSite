class ChangeDefaultOnFaqGroups < ActiveRecord::Migration
	def up
		change_column :faq_groups, :published, :boolean, :default => false
	end

	def down
		change_column :faq_groups, :published, :boolean, :default => nil
	end
end
