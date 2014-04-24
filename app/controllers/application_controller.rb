class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private

  def confirm_logged_in

    unless session[:user_id]
      flash[:notice] = "Please login"
      redirect_to(:controller=>'access', :action => 'login')
      return false; # halts the return action
    else
      return true;
    end
  end

  def read_faq_opinions_from_cookies
    return cookies[:faq_useful].nil? ? Array.new : JSON.parse(cookies[:faq_useful])
  end

  def write_faq_opinions_in_cookies(id)
    voted_faqs = cookies[:faq_useful].nil? ? Array.new : JSON.parse(cookies[:faq_useful])
    voted_faqs << id
    cookies[:faq_useful] = JSON.generate(voted_faqs.uniq)
  end
  
end
