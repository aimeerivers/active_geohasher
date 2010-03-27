class GeohashesController < ApplicationController

  def show
    begin
      if params.include?('date') && params.include?('latitude') && params.include?('longitude')
        @geohash = Geohash.find_or_create(Date.parse(params[:date]), params[:latitude], params[:longitude])
      else
        @geohash = Geohash.find(params[:id].to_i(36))
      end
      @graticule = @geohash.graticule
      respond_to do |format|
        format.html
        format.pdf do
          prawnto :inline => false, :prawn => prawn_options, :filename => 'test.pdf'
          render :layout => false
        end
      end
    # rescue
    #   flash[:error] = "Geohash not found, or there was a problem looking it up."
    #   redirect_to root_path
    end
  end
  
  private
  
  def prawn_options
    options = {
      :page_size => 'A4',
      :left_margin => 90, :right_margin => 90,
      :top_margin => 50, :bottom_margin => 50
    }
  end

end
