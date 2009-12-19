class GraticulesController < ApplicationController
  
  def show
    if params[:id]
      @graticule = Graticule.find(params[:id])
    else
      @graticule = Graticule.find_or_create_by_latitude_and_longitude(params[:latitude], params[:longitude])
    end

    if @graticule.nil?
      flash[:error] = 'Sorry, the graticule was not found'
      redirect_to root_path
      return
    end

    respond_to do |format|
      format.kml { render :layout => false }
      format.html
    end
  end
  
  def geohashes
    @graticule = Graticule.find(params[:id])
    respond_to do |format|
      format.kml { render :layout => false }
    end
  end
  
end

