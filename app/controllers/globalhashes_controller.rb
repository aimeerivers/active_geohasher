class GlobalhashesController < ApplicationController

  def index
    @globalhashes = Globalhash.latest
  end

  def show
    begin
      if params.include?('date')
        @globalhash = Globalhash.find_or_create(Date.parse(params[:date]))
      else
        @globalhash = Globalhash.find(params[:id].to_i(36))
      end
      raise 'Globalhash not found' if @globalhash.nil?
    rescue
      flash[:error] = t('globalhashes.show.not_found')
      redirect_to root_path
    end
  end

end
