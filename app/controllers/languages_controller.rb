class LanguagesController < ApplicationController

  def set
    if AVAILABLE_LOCALES.include?(params[:locale])
      I18n.locale = session[:locale] = params[:locale]
      flash[:success] = t('locale.language_set_to', :language => t("locale.#{params[:locale]}"))
    else
      flash[:error] = "Sorry, that language is not currently available."
    end

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

end
