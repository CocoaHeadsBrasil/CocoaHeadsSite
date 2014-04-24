class Post < ActiveRecord::Base

	belongs_to :author, :class_name => "AdminUser"
	before_validation :add_default_permalink

	acts_as_taggable
	acts_as_list

	validates :title, :presence => true,
	                  :length => { :maximum => 255 }
	validates :intro, :presence => true
	validates_uniqueness_of :permalink

	scope :newest_first, lambda { order("posts.created_at DESC") }
	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	

	private 

	def add_default_permalink
		if permalink.blank?
			self.permalink = "#{id}-#{title.parameterize}"
		end
	end

end
