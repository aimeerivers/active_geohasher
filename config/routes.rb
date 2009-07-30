ActionController::Routing::Routes.draw do |map|
  
  map.rpx '/rpx', :controller => 'sessions', :action => 'rpx'
  map.signout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.root :controller => 'home'
end
