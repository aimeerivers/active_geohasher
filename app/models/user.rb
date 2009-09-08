class User < ActiveRecord::Base
  
  validates_presence_of :name, :on => :update
  
  has_many :subscriptions, :dependent => :destroy
  has_many :graticules, :through => :subscriptions
  
  named_scope :receiving_email, :conditions => "email IS NOT NULL AND email <> '' AND receive_email = 1"
  
  def location_set?
    !(lat.nil? || lng.nil? || lat == 0 || lng == 0)
  end
  
  def subscribe_to_graticule(graticule)
    return if graticule.nil?
    graticules << graticule unless graticules.include?(graticule)
  end
  
  def unsubscribe_from_graticule(graticule)
    return if graticule.nil?
    graticules.delete(graticule) if graticules.include?(graticule)
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

