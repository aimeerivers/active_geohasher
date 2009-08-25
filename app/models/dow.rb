class Dow < ActiveRecord::Base
  
  include GeohashCalculator
  
  def self.find_or_create_for_date(date)
    self.find_by_date(date.strftime('%Y-%m-%d')) || self.create_for_date(date)
  end
  
  private
  
  def self.create_for_date(date)
    dow = GeohashCalculator::dow_for(date)
    return nil if dow.nil?
    self.create!(:date => date.strftime('%Y-%m-%d'), :dow => dow)
  end
  
end

