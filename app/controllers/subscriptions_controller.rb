class SubscriptionsController < ApplicationController
  before_filter :login_required
  
  def create
    graticule = Graticule.find_or_create_by_latitude_and_longitude(params[:latitude], params[:longitude])
    current_user.graticules << graticule
    redirect_to root_path
  end
end
