class UsersController < ApplicationController
  before_filter :login_required
  
  def location
  end
  
  def update_location
    current_user.update_attributes(:lat => params[:user][:lat], :lng => params[:user][:lng])
    
    respond_to do |format|
      format.js { render :update_location }
      format.html do
        flash[:notice] = "Your location has been saved."
        redirect_to location_path
      end
    end
  end
  
  def subscribe
  end
  
end

