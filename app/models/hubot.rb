class Hubot
  def self.send_message(message, channel="#cocoaheadsbr")
    unless ENV['HUBOT_URL'].blank?
      params = {'channel' => channel, 'message' => message}
      Net::HTTP.post_form(URI.parse("#{ENV['HUBOT_URL']}/post/chbr/website"), params)
    end
  end
end