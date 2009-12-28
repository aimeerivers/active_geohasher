class GeohashesController < ApplicationController

  def show
    begin
      if params.include?('date') && params.include?('latitude') && params.include?('longitude')
        @geohash = Geohash.find_or_create(Date.parse(params[:date]), params[:latitude], params[:longitude])
      else
        @geohash = Geohash.find(params[:id].to_i(36))
      end
      @graticule = @geohash.graticule
    rescue
      flash[:error] = "Geohash not found, or there was a problem looking it up."
      redirect_to root_path
    end
  end

end
