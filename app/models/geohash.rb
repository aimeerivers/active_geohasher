class Geohash < ActiveRecord::Base
  
  belongs_to :graticule
  belongs_to :history
  
  named_scope :new_since, lambda {|datetime| {:conditions => ["created_at >= ?", datetime.utc]}}
  
  def peeron_link
    "http://irc.peeron.com/xkcd/map/map.html?date=#{date.strftime('%Y-%m-%d')}&lat=#{graticule.latitude}&long=#{graticule.longitude}&zoom=8"
  end
  
  def wiki_link
    "http://wiki.xkcd.com/geohashing/#{date.strftime('%Y-%m-%d')}_#{graticule.latitude}_#{graticule.longitude}"
  end
  
  def google_link
    "http://maps.google.com/?ie=UTF8&ll=#{lat},#{lng}&z=8&q=loc:#{lat},#{lng}"
  end
  
  def directions_link(latitude, longitude)
    "http://maps.google.com/maps?daddr=#{self.lat},#{self.lng}&saddr=#{latitude},#{longitude}"
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
  
  def description
    "#{date.strftime('%A')} #{date}: #{latitude_display}, #{longitude_display}: #{place_name_display}"
  end
  
  def self.find_or_create(date, latitude, longitude)
    graticule = Graticule.find_or_create_by_latitude_and_longitude(latitude, longitude)
    return nil if graticule.nil?
    
    self.find_by_date_and_graticule_id(date.strftime('%Y-%m-%d'), graticule.id) || self.create_for_date_and_graticule(date, graticule)
  end
  
  private
  
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
  
end

