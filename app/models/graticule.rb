class Graticule < ActiveRecord::Base
  
  validates_format_of :latitude, :with => /^-?\d{1,2}$/
  validates_format_of :longitude, :with => /^-?\d{1,3}$/
  
  validate :legitimate_latitude
  validate :legitimate_longitude
  
  def legitimate_latitude
    errors.add_to_base("Latitude is invalid") unless latitude.to_i.abs <= 90
  end
  
  def legitimate_longitude
    errors.add_to_base("Longitude is invalid") unless longitude.to_i.abs <= 180
  end
  
  has_many :geohashes
  
  named_scope :by_latitude_and_longitude, :order => 'latitude, longitude'
  named_scope :without_names, :conditions => {:name => nil}
  
  def wiki_link
    "http://wiki.xkcd.com/geohashing/#{latitude}%2C#{longitude}"
  end
  
  def peeron_link
    "http://irc.peeron.com/xkcd/map/map.html?lat=#{latitude}&long=#{longitude}&zoom=8"
  end
  
  def anthill_link(for_user=nil, date=nil)
    latitude_to_use = "#{latitude}.5"
    longitude_to_use = "#{longitude}.5"
    if (for_user && for_user.lives_in?(self))
      latitude_to_use = for_user.latitude_display
      longitude_to_use = for_user.longitude_display
    end
    date_to_use = date.nil? ? '' : date.strftime('%Y-%m-%d')
    "http://tjum.anthill.de/cgi-bin/geohash.cgi?lat=#{latitude_to_use}&lon=#{longitude_to_use}&nr=o&map=g&size=300x200&t=&date=#{date_to_use}"
  end

  def tag
    @tag ||= "geohashing#{n_or_s}#{latitude.to_i.abs}#{w_or_e}#{longitude.to_i.abs}"
  end

  def twitter_hashtag_link
    "http://twitter.com/#search?q=%23#{tag}"
  end

  def flickr_link
    "http://www.flickr.com/photos/tags/#{tag}/"
  end

  def youtube_link
    "http://www.youtube.com/results?search_query=#{tag}&search=tag"
  end

  def latitude_longitude_display
    "#{latitude}, #{longitude}"
  end
  
  def display_name
    "#{latitude_longitude_display}: #{name}"
  end
  
  def google_map(request)
    returning String.new do |str|
      str << "http://maps.google.com/staticmap"
      str << "?size=300x400"
      str << "&center=#{latitude}.500000,#{longitude}.500000"
      str << "&zoom=8"
      str << "&path=rgba:0xff000080,weight:2|#{south_east}|#{south_west}|#{north_west}|#{north_east}|#{south_east}"
      str << "&key=#{GOOGLE_MAPS_API_KEY[request.host]}"
      str << "&sensor=false"
    end
  end

  def google_map_with_latest_geohashes(request)
    returning String.new do |str|
      str << google_map(request)
      geohashes.latest.each do |geohash|
        str << "&markers=#{geohash.lat},#{geohash.lng}"
      end
    end
  end
  
  def get_name_from_geohashing_wiki
    require 'open-uri'
    require 'hpricot'
    doc = Hpricot(open(wiki_link))
    title = doc.search('h1.firstHeading').first.inner_html
    self.update_attribute(:name, title)
    title
  end
    
  def w30?
    longitude.to_i > -30
  end
  
  def self.find_or_create_by_latitude_and_longitude(latitude, longitude)
    graticule = self.find_by_latitude_and_longitude(latitude, longitude)
    return graticule unless graticule.nil?
    
    graticule = self.create(:latitude => latitude, :longitude => longitude)
    return nil if graticule.errors.any?
    
    graticule
  end

  private

  def north_east
    "#{north},#{east}"
  end

  def south_east
    "#{south},#{east}"
  end

  def south_west
    "#{south},#{west}"
  end

  def north_west
    "#{north},#{west}"
  end

  def south
    @south ||= latitude.include?('-') ? (latitude.to_i - 1).to_s : latitude
  end

  def north
    @north ||= latitude.include?('-') ? latitude : (latitude.to_i + 1).to_s
  end

  def east
    @east ||= longitude.include?('-') ? longitude : (longitude.to_i + 1).to_s
  end

  def west
    @west ||= longitude.include?('-') ? (longitude.to_i - 1).to_s : longitude
  end

  def n_or_s
    @n_or_s ||= latitude.include?('-') ? 'S' : 'N'
  end

  def w_or_e
    @w_or_e ||= longitude.include?('-') ? 'W' : 'E'
  end
  
end

