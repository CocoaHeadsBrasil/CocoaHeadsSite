class Faq < ActiveRecord::Base

	belongs_to :faq_group

	acts_as_list :scope => :faq_group

	after_save :touch_faq_group

	# shortcut validations, aka "sexy validations"
	validates :question, :presence => true
	validates :answer, :presence => true
	validates :position, :presence => true

	scope :sorted, lambda { order("faqs.position ASC") }
	scope :published, lambda { where(:published => true) }
	scope :unpublished, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["title LIKE ?", "%#{query}%"])
	}

	def markAsUseful
		self.useful_yes += 1
	end

	def markAsUnuseful
		self.useful_no += 1
	end

	private

	def touch_faq_group
		# touch is similar to:
		# faq_group.update_attribute(:updated_at, Time.now)
		puts faq_group

		# Everytime the faq is updated, we update the group
	end
end
