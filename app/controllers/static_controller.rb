class StaticController < ApplicationController
  before_filter :login_required
  
  layout false
  
  def upcoming_geohashes
    @user = current_user
    @start_time = 3.days.ago
    render :template => "notifier/upcoming_geohashes.text.#{params[:format]}"
  end
  
  def debug
    render :text => request.headers.inspect
  end
  
end

