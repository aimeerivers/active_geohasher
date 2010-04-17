class ProfilesController < ApplicationController
  before_filter :login_required
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      @user.preferred_links = (params[:preferred_links] || []).join(',')
      @user.set_preferred_locale(params[:user][:preferred_locale])
      @user.save
      I18n.locale = session[:locale] = @user.preferred_locale
      flash[:success] = t('profiles.edit.updated_successfully')
      redirect_to edit_profile_path
    else
      render :edit
    end
  end
  
end

