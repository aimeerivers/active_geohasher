class Subscription < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :graticule
  
  named_scope :by_graticule_latitude_and_longitude,
    :joins => :graticule,
    :order => 'latitude, longitude'
  
end

