class ProfilesController < ApplicationController
  before_filter :login_required
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      @user.preferred_links = (params[:preferred_links] || []).join(',')
      @user.save
      flash[:success] = "Your profile was updated succesfully."
      redirect_to edit_profile_path
    else
      render :edit
    end
  end
  
end

