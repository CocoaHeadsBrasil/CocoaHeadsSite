class ChangeQuestionFieldOnFaq < ActiveRecord::Migration
	def up
		change_column :faqs, :answer, :text
	end

	def down
		change_column :faqs, :answer, :string
	end
end
