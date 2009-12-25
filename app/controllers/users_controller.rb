class UsersController < ApplicationController
  before_filter :login_required
  
  def location
    if current_user.location_set?
      @lat = current_user.lat
      @lng = current_user.lng
      @location_set = true
    else
      location = Geokit::Geocoders::MultiGeocoder.geocode(request.headers['REMOTE_ADDR'].split(',').first)
      @lat = location.lat || 49
      @lng = location.lng || 14
      @location_set = false
    end
  end
  
  def update_location
    lat, lng = params[:user][:lat], params[:user][:lng]
    current_user.update_attributes(:lat => lat, :lng => lng)
    current_user.subscribe_to_graticule(Graticule.find_or_create_by_latitude_and_longitude(lat.to_s.split('.').first, lng.to_s.split('.').first))
    
    respond_to do |format|
      format.js { render :update_location }
      format.html do
        flash[:success] = "Your location has been saved."
        redirect_to location_path
      end
    end
  end
  
  def subscribe
  end
  
end

