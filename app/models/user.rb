class User < ActiveRecord::Base
  
  validates_presence_of :name, :on => :update
  
  has_many :subscriptions, :dependent => :destroy
  has_many :graticules, :through => :subscriptions
  has_many :custom_links
  
  named_scope :receiving_email, :conditions => "email IS NOT NULL AND email <> '' AND receive_email = true"
  
  DISTANCE_UNITS = ['miles', 'kms']
  preference :distance_units, :string, :default => 'miles'

  AVAILABLE_LINKS = ['ag', 'wiki', 'google', 'bing', 'osm', 'directions', 'peeron', 'anthill', 'geocaching']
  preference :links, :string, :default => "ag,wiki,google,bing,osm,directions,peeron,anthill"
  
  def location_set?
    !(lat.nil? || lng.nil? || lat == 0 || lng == 0)
  end
  
  def subscribe_to_graticule(graticule)
    return if graticule.nil?
    graticules << graticule unless subscribed_to_graticule?(graticule)
  end
  
  def unsubscribe_from_graticule(graticule)
    return if graticule.nil?
    graticules.delete(graticule) if subscribed_to_graticule?(graticule)
  end

  def subscribed_to_graticule?(graticule)
    graticules.include?(graticule)
  end
  
  def home_location
    return nil if !location_set?
    Geokit::LatLng.new(lat, lng)
  end
  
  def lives_in?(graticule)
    return false if !location_set?
    graticule.latitude.to_i == lat.to_i && graticule.longitude.to_i == lng.to_i
  end
  
  def latitude_display
    lat.round(5).to_s
  end
  
  def longitude_display
    lng.round(5).to_s
  end
  
  def distance_to(lat, lng)
    return '' if !location_set?
    "#{home_location.distance_to(Geokit::LatLng.new(lat, lng), :units => preferred_distance_units.to_sym).round(1)} #{I18n.t(preferred_distance_units)}"
  end

  def new_geohashes_since(start_time)
    graticules.by_latitude_and_longitude.map do |graticule|
      graticule.geohashes.new_since(start_time)
    end.flatten.group_by(&:date)
  end
  
  def self.create_with_rpx(rpx_data)
    User.create!({
      :identifier => rpx_data['identifier'],
      :email => rpx_data['verifiedEmail'] || rpx_data['email'],
      :name => rpx_data['displayName'] || rpx_data['preferredUsername']
    })
  end
  
  def self.find_or_create_with_rpx(rpx_data)
    User.find_by_identifier(rpx_data['identifier']) || User.create_with_rpx(rpx_data)
  end
  
end

