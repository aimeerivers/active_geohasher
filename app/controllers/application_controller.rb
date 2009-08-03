# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user, :logged_in?
  
  def current_user
    session[:current_user]
  end
  
  def logged_in?
    !session[:current_user].nil?
  end
  
  def login_required
    if !logged_in?
      flash[:error] = 'Please sign in first'
      redirect_to root_path
    end
  end
  
end
