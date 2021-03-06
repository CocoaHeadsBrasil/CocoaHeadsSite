class Content < ActiveRecord::Base

	acts_as_list

	before_validation :add_default_permalink
	after_create :send_hubot_create_message

	# shortcut validations, aka "sexy validations"
	validates :title, :presence => true
	validates :permalink, :presence => true,
	                :length => { :within => 3..255 },
	                :uniqueness => true
	validates :position, :presence => true
	validates :published, :presence => true

	scope :sorted, lambda { order("contents.position ASC") }
	scope :newest_first, lambda { order("contents.created_at DESC") }
	scope :published, lambda { where(:published => true) }
	scope :unpublished, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["title LIKE ?", "%#{query}%"])
	}

	# mount_uploader :image, ImageUploader

	private 

	def add_default_permalink
		if permalink.blank?
			self.permalink = "#{title.parameterize}"
		end
	end

	def send_hubot_create_message
		Hubot.send_message "Novo conteúdo criado no website do CocoaHeadsBR: #{self.title} (http://www.cocoaheads.com.br/#{self.permalink})"
	end
end
