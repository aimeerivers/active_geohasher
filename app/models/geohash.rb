class Geohash < ActiveRecord::Base
  
  belongs_to :graticule
  belongs_to :history
  
  def self.create_for_date_and_graticule(date, graticule)
    history = History.for(date, graticule.w30?)
    return nil if history.nil?
    
    lat = "#{graticule.latitude}.#{history.lat.to_s.split('.').last}"
    lng = "#{graticule.longitude}.#{history.lng.to_s.split('.').last}"
    
    place = Geokit::Geocoders::GoogleGeocoder.reverse_geocode("#{lat}, #{lng}")
    
    self.create!({
      :date => date,
      :graticule => graticule,
      :history => history,
      :lat => lat,
      :lng => lng,
      :place_name => place.full_address
    })
  end
  
  def self.find_or_create(date, latitude, longitude)
    graticule = Graticule.find_or_create_by_latitude_and_longitude(latitude, longitude)
    self.find_by_date_and_graticule_id(date.strftime('%Y-%m-%d'), graticule.id) || self.create_for_date_and_graticule(date, graticule)
  end
  
end

