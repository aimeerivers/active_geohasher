class CustomLink < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :name
  validates_format_of :url, :with => /^https?:\/\/.+/, :message => 'is invalid (try with http://)'

  named_scope :newest_first, :order => 'created_at DESC'

end
