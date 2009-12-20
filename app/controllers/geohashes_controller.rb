class GeohashesController < ApplicationController

  def show
    @geohash = Geohash.find(params[:id].to_i(36))
    @graticule = @geohash.graticule
  end

end
