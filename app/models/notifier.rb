class Notifier < ActionMailer::Base
  include ApplicationHelper

  def upcoming_geohashes(user, start_time)
    I18n.locale = user.preferred_locale
    subject    "#{I18n.t('notifier.upcoming_geohashes.geohashing_adventures')} [#{geohashing_dates(user, start_time)}]"
    recipients user.email
    from       'activegeohasher@googlemail.com'
    sent_on    Time.now
    
    body       :user => user, :start_time => start_time
  end

  private

  def geohashing_dates(user, start_time)
    user.new_geohashes_since(start_time).keys.map{|date| I18n.l(date, :format => :short)}.join(', ')
  end

end

