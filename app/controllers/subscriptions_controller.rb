class SubscriptionsController < ApplicationController
  before_filter :login_required
  
  def create
    graticule = Graticule.find_or_create_by_latitude_and_longitude(params[:latitude], params[:longitude])
    if current_user.subscribe_to_graticule(graticule)
      flash[:success] = t('subscriptions.new.successfully_subscribed_to_graticule')
    else
      flash[:error] = t('subscriptions.new.could_not_subscribe_to_graticule')
    end
    redirect_to subscribe_path
  end
  
  def destroy
    subscription = Subscription.find(params[:id])
    current_user.unsubscribe_from_graticule(subscription.graticule)
    flash[:success] = t('subscriptions.unsubscribe.successfully_unsubscribed')
    redirect_to subscribe_path
  end
end
