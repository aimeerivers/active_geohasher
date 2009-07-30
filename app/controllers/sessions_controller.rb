class SessionsController < ApplicationController
  
  def rpx
    rpx_token = params[:token]

    rpx = Net::HTTP.new('rpxnow.com', 443)
    rpx.use_ssl = true
    path = "/api/v2/auth_info"
    args = "apiKey=#{RPX_API_KEY}&token=#{rpx_token}"
    http_resp, response_data = rpx.post(path, args)

    rpx_data = JSON.parse(response_data)
    session[:current_user] = User.find_or_create_with_rpx(rpx_data['profile'])
    redirect_to root_path
  end
  
  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end
  
end
