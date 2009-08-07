class UsersController < ApplicationController
  before_filter :login_required
  
  def location
  end
  
  def update_location
    current_user.update_attributes(:lat => params[:lat], :lng => params[:lng])
  end
  
end
