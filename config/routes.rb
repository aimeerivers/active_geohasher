ActionController::Routing::Routes.draw do |map|
  
  map.rpx '/rpx', :controller => 'sessions', :action => 'rpx'
  map.signout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.location '/location', :controller => 'users', :action => 'location'
  map.update_location '/update_location', :controller => 'users', :action => 'update_location', :conditions => { :method => :put }
  
  map.subscribe '/subscribe', :controller => :users, :action => :subscribe
  
  map.resource :profile, :only => [:edit, :update]
  
  map.resources :subscriptions
  map.resources :graticules, :only => [:show], :member => {:geohashes => :get}
  
  map.privacy '/privacy', :controller => :home, :action => :privacy

  map.connect '/graticule/:latitude/:longitude', :controller => :graticules, :action => :show
  
  map.root :controller => 'home'
  
  map.upcoming_geohashes '/static/upcoming_geohashes/:format', :controller => :static, :action => :upcoming_geohashes, :format => 'html'
  map.debug '/static/debug', :controller => :static, :action => :debug
  
end

