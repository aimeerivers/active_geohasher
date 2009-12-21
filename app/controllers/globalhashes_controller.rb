class GlobalhashesController < ApplicationController

  def index
    @globalhashes = Globalhash.latest
  end

end
