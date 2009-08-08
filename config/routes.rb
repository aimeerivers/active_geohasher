ActionController::Routing::Routes.draw do |map|
  
  map.rpx '/rpx', :controller => 'sessions', :action => 'rpx'
  map.signout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.location '/location', :controller => 'users', :action => 'location'
  map.update_location '/update_location', :controller => 'users', :action => 'update_location', :conditions => { :method => :put }
  
  map.subscribe '/subscribe', :controller => :users, :action => :subscribe
  
  map.resources :subscriptions
  
  map.root :controller => 'home'
end
