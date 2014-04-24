class ImageWorker
	include Sidekiq::Worker
	# Prevents rerun the perform method if any fail
	# sidekiq_options retry: false

	def perform(id, key)
		admin_user = AdminUser.find(id)
		admin_user.key = key
		admin_user.remote_avatar_url = admin_user.avatar.direct_fog_url(with_path: true)
		admin_user.image_processed = true
		admin_user.save!
	end
end