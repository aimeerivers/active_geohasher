class Geohash < ActiveRecord::Base
  
  belongs_to :graticule
  belongs_to :history
  
  named_scope :new_since, lambda {|datetime| {:conditions => ["created_at >= ?", datetime.utc]}}
  named_scope :latest, lambda { { :conditions => ['date >= ?', 1.day.ago] } }

  def to_param
    id.to_s(36)
  end
  
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
  
  def bing_link
    "http://www.bing.com/maps/?v=2&where1=#{lat}%2C%20#{lng}&encType=1"
  end
  
  def anthill_link(for_user=nil)
    graticule.anthill_link(for_user, date)
  end
  
  def osm_link
    "http://www.openstreetmap.org/index.html?mlat=#{lat}&mlon=#{lng}"
  end

  def geocaching_link
    "http://www.geocaching.com/seek/nearest.aspx?origin_lat=#{lat}&origin_long=#{lng}&dist=3"
  end
  
  def place_name_display
    return '[unknown location]' if place_name.blank?
    place_name
  end
  
  def latitude_display
    lat.round(5).to_s
  end
  
  def longitude_display
    lng.round(5).to_s
  end

  def latitude_longitude_display
    "#{latitude_display}, #{longitude_display}"
  end

  def graticule_display_name
    return '' if graticule.nil?
    graticule.display_name
  end
  
  def description
    "#{date.strftime('%A')} #{date}: #{latitude_display}, #{longitude_display}: #{place_name_display}"
  end

  def google_map_with_graticule(request)
    returning String.new do |str|
      str << graticule.google_map(request)
      str << "&markers=#{lat},#{lng}"
    end
  end
  
  def google_map(request, zoomlevel=12, maptype='roadmap')
    returning String.new do |str|
      str << "http://maps.google.com/staticmap"
      str << "?size=300x200"
      str << "&center=#{lat},#{lng}"
      str << "&markers=#{lat},#{lng}"
      str << "&zoom=#{zoomlevel}"
      str << "&maptype=#{maptype}"
      str << "&key=#{GOOGLE_MAPS_API_KEY[request.host]}"
      str << "&sensor=false"
    end
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

