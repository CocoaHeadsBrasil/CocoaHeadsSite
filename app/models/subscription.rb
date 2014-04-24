class Subscription < ActiveRecord::Base

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	validates :email, 	:presence => true,
	            		:format => { :with => EMAIL_REGEX }, 
	            		:uniqueness => true
	validates :first_name, :presence => true
	validates :last_name, :presence => true

	scope :sorted, lambda { order("subscriptions.email ASC") }
	scope :last_week, lambda { where("created_at >= ?", 1.week.ago.utc) }

	def name
		first_name+" "+last_name
	end

end