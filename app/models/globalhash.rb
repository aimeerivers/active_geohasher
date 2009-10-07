class Globalhash < ActiveRecord::Base
  
  belongs_to :history
  
  named_scope :new_since, lambda {|datetime| {:conditions => ["created_at >= ?", datetime.utc]}}
  
  def google_link
    "http://maps.google.com/?ie=UTF8&ll=#{lat},#{lng}&z=8&q=loc:#{lat},#{lng}"
  end
  
  def osm_link
    "http://www.openstreetmap.org/index.html?mlat=#{lat}&mlon=#{lng}"
  end
  
  def place_name_display
    return '(unknown location)' if place_name.blank?
    place_name
  end
  
  def latitude_display
    lat.round(5).to_s
  end
  
  def longitude_display
    lng.round(5).to_s
  end
  
  def self.find_or_create(date)
    self.find_by_date(date.strftime('%Y-%m-%d')) || self.create_for_date(date)
  end
  
  private
  
  def self.create_for_date(date)
    history = History.for(date, true)
    return nil if history.nil?
    
    lat = (history.lat * 180) - 90
    lng = (history.lng * 360) - 180
    
    place = Geokit::Geocoders::GoogleGeocoder.reverse_geocode("#{lat}, #{lng}")
    
    self.create!({
      :date => date,
      :history => history,
      :lat => lat,
      :lng => lng,
      :place_name => place.full_address
    })
  end
  
end
