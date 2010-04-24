class CustomLink < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :name
  validates_format_of :url, :with => /^https?:\/\/.+/, :message => I18n.t('custom_links.index.is_invalid')

  named_scope :newest_first, :order => 'created_at DESC'

  def magic_url(hash)
    return_url = url.dup
    hash.each do |key, value|
      return_url.gsub!(/\[#{key.to_s.upcase}\]/, value.to_s)
    end
    return_url
  end

end
