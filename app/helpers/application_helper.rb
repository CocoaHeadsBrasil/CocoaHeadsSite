module ApplicationHelper

	def error_messages_for(object)
		render(:partial => 'application/error_messages', :locals => {:object => object})
	end

	def nav_link(link_text, link_path)
		class_name = current_page?(link_path) ? "active" : ""

		content_tag(:li, :class => class_name) do
			concat link_to link_text, link_path
			concat content_tag(:div, "&nbsp;".html_safe, :class => 'separator')
		end
	end

	def admin_nav_link(link_text, link_path)
		class_name = current_page?(link_path) ? "active" : ""

		content_tag(:li, :class => class_name) do
			link_to link_text, link_path
		end
	end

	def dropdown_nav_link(controller, options={})
		default_classes = options[:class]
		class_name = params[:controller] == controller ? "active #{default_classes}" : "#{default_classes}"

		"<li class=\"#{class_name}\">".html_safe
	end

	def item_nav_link(link_text, link_path, child_controller={})

		class_name = params[:controller] ==  link_path[:controller] ||
						current_page?(controller: child_controller) ? "active" : ""

		content_tag(:li, :class => class_name) do
			link_to link_text, link_path
		end
	end

	def status_tag(boolean, options={})
		options[:true_text] ||= ''
		options[:false_text] ||= ''
		if boolean
			content_tag(:span, options[:true_text], :class => 'label label-success')
		else
			content_tag(:span, options[:false_text], :class => 'label label-default')
		end
	end

end