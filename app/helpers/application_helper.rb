# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def sign_in_link
    link_to t('authentication.sign_in'), "https://#{ENV['RPX_REALM']}.rpxnow.com/openid/v2/signin?token_url=#{rpx_url}", :class => 'rpxnow', :onclick => 'return false;'
  end
  
end

