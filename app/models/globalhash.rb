class Globalhash < ActiveRecord::Base
  include GenericGeohash
  
  belongs_to :history
  
  named_scope :new_since, lambda {|datetime| {:conditions => ["created_at >= ?", datetime.utc]}}
  named_scope :latest, lambda { { :conditions => ['date >= ?', 1.day.ago] } }
  
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
