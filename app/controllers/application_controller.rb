# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user, :logged_in?
  before_filter :set_locale, :remember_gets
  
  def current_user
    return nil if !logged_in?
    User.find(session[:current_user_id])
  end
  
  def logged_in?
    !session[:current_user_id].nil?
  end
  
  def login_required
    if !logged_in?
      flash[:error] = t('authentication.please_sign_in_first')
      redirect_to root_path
    end
  end

  def set_locale
    I18n.locale = session[:locale]
  end

  def last_get
    session[:last_get]
  end

  def remember_gets
    session[:last_get] = request.path if request.get?
  end
  
end
