require 'csv'

module VideosHelper

	def youtube_embed_code(options={})
		width = options[:width] ? options[:width] : 853
		height = options[:height] ? options[:height] : 480
		src = options[:src]

		"<iframe width=\"" + width + "\" height=\"" + height + "\" src=\"" + src + "\" frameborder=\"0\" allowfullscreen></iframe>".html_safe
	end

	def render123_tags(tags, options={})

		tag_array = CSV.parse_line(tags)

		content_tag(:div, :class => 'tags') do
			concat tag_array.collect {|item| (content_tag(:span, item, :class => 'btn btn-primary btn-xs'))}.join("").html_safe
		end
	end
end
