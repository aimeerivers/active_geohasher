class StaticController < ApplicationController
  before_filter :login_required
  
  layout false
  
  def upcoming_geohashes
    @user = current_user
    @start_time = Time.now.at_beginning_of_day
    render :template => "notifier/upcoming_geohashes.text.#{params[:format]}"
  end
  
end

