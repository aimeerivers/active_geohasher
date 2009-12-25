ActionController::Routing::Routes.draw do |map|
  
  map.rpx '/rpx', :controller => 'sessions', :action => 'rpx'
  map.signout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.location '/location', :controller => 'users', :action => 'location'
  map.update_location '/update_location', :controller => 'users', :action => 'update_location', :conditions => { :method => :put }
  
  map.subscribe '/subscribe', :controller => :users, :action => :subscribe
  
  map.resource :profile, :only => [:edit, :update]
  
  map.resources :subscriptions
  map.resources :graticules, :only => [:show], :member => {:geohashes => :get}
  map.resources :geohashes, :only => [:show]
  map.resources :globalhashes, :only => [:index]
  map.resources :custom_links, :only => [:index, :create, :edit, :update, :destroy]
  
  map.privacy '/privacy', :controller => :home, :action => :privacy
  map.what_is_geohashing '/what_is_geohashing', :controller => :home, :action => :what_is_geohashing

  map.pretty_graticule '/graticule/:latitude/:longitude', :controller => :graticules, :action => :show
  
  map.root :controller => 'home'
  
  map.upcoming_geohashes '/static/upcoming_geohashes/:format', :controller => :static, :action => :upcoming_geohashes, :format => 'html'
  map.debug '/static/debug', :controller => :static, :action => :debug
  
end

