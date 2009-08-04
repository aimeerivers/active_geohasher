class Graticule < ActiveRecord::Base
  
  validates_format_of :latitude, :with => /^-?\d{1,2}$/
  validates_format_of :longitude, :with => /^-?\d{1,3}$/
  
  named_scope :by_latitude_and_longitude, :order => 'latitude, longitude'
  
  def self.find_or_create_by_latitude_and_longitude(latitude, longitude)
    graticule = self.find_by_latitude_and_longitude(latitude, longitude)
    return graticule unless graticule.nil?
    
    graticule = self.create(:latitude => latitude, :longitude => longitude)
    return nil if graticule.errors.any?
    
    graticule
  end
  
end

