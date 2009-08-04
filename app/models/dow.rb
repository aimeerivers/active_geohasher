class Dow < ActiveRecord::Base
  
  include Geohash
  
  def self.create_for_date(date)
    dow = Geohash::dow_for(date)
    return nil if dow.nil?
    self.create!(:date => date, :dow => dow)
  end
  
  def self.find_or_create_for_date(date)
    self.find_by_date(date.strftime('%Y-%m-%d')) || self.create_for_date(date)
  end
  
end

