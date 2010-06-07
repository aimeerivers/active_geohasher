class LanguagesController < ApplicationController
  skip_before_filter :remember_gets

  def set
    if (AVAILABLE_LOCALES + SECRET_LOCALES).include?(params[:locale])
      I18n.locale = session[:locale] = params[:locale]
      current_user.set_preferred_locale(params[:locale]) if logged_in?
      flash[:success] = t('locale.language_set_to', :language => t("locale.#{params[:locale]}"))
    else
      flash[:error] = t('locale.not_available')
    end

    redirect_to last_get || root_path
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

end
