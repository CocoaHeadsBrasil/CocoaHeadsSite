class Hubot
  def self.send_message(message, options={})
    unless ENV['HUBOT_URL'].blank?
      params = {'message' => message}

	  unless options[:mood].blank? 
	    params[:mood] = options[:mood]
	  else
	  	params[:mood] = "good"
	  end

	  unless options[:channel].blank? 
	    params[:channel] = options[:channel]
	  else
	  	params[:channel] = "#cocoaheads"
	  end

      Net::HTTP.post_form(URI.parse("#{ENV['HUBOT_URL']}/post/chbr/website"), params)
    end
  end
end