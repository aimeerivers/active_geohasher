class GraticulesController < ApplicationController
  
  def show
    @graticule = Graticule.find(params[:id])
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

