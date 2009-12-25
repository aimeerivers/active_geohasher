class SubscriptionsController < ApplicationController
  before_filter :login_required
  
  def create
    graticule = Graticule.find_or_create_by_latitude_and_longitude(params[:latitude], params[:longitude])
    current_user.subscribe_to_graticule(graticule)
    flash[:success] = "Successfully subscribed to graticule."
    redirect_to subscribe_path
  end
  
  def destroy
    subscription = Subscription.find(params[:id])
    current_user.unsubscribe_from_graticule(subscription.graticule)
    flash[:success] = "Successfully unsubscribed from graticule."
    redirect_to subscribe_path
  end
end
