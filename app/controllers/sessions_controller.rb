class SessionsController < ApplicationController
  
  def rpx
    rpx_token = params[:token]

    rpx = Net::HTTP.new('rpxnow.com', 443)
    rpx.use_ssl = true
    path = "/api/v2/auth_info"
    args = "apiKey=#{ENV['RPX_API_KEY']}&token=#{rpx_token}"
    http_resp, response_data = rpx.post(path, args)

    rpx_data = JSON.parse(response_data)
    session[:current_user_id] = User.find_or_create_with_rpx(rpx_data['profile']).id
    I18n.locale = session[:locale] = current_user.preferred_locale
    if !current_user.location_set?
      redirect_to location_path
    else
      redirect_to subscribe_path
    end
  rescue
    flash[:error] = "FAIL!! Something went wrong and you could not be signed in, sorry."
    redirect_to root_path
  end
  
  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end
  
end
