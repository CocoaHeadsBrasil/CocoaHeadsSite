class FaqGroup < ActiveRecord::Base

	has_many :faqs

	acts_as_list

	# shortcut validations, aka "sexy validations"
	validates :title, :presence => true
	validates :position, :presence => true

	scope :sorted, lambda { order("faq_groups.position ASC") }
	scope :published, lambda { where(:published => true) }
	scope :unpublished, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["title LIKE ?", "%#{query}%"])
	}

end
