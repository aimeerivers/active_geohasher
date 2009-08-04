class History < ActiveRecord::Base
  
  include Geohash
  
  belongs_to :dow
  
  def self.create_for_date(date, w30)
    dow = Dow.find_or_create_for_date(w30 ? date-1.day : date)
    return nil if dow.nil?
    key = "#{date.strftime('%Y-%m-%d')}-#{dow.dow}"
    md5 = Digest::MD5.hexdigest(key)
    lat, lng = Geohash::coordinates_for(md5)
    self.create!({
      :date => date,
      :w30 => w30,
      :dow => dow,
      :key => key,
      :md5 => md5,
      :lat => lat,
      :lng => lng
    })
  end
  
  def self.for(date, w30)
    self.find_by_date_and_w30(date.strftime('%Y-%m-%d'), w30) || self.create_for_date(date, w30)
  end
  
end

