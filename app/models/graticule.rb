class Graticule < ActiveRecord::Base
  
  validates_presence_of :latitude, :longitude
  
  named_scope :by_latitude_and_longitude, :order => 'latitude, longitude'
  
end
