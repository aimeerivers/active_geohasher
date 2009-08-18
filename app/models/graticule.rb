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
  
  def display_name
    "#{latitude}, #{longitude} #{name}"
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
  
end

