class Notifier < ActionMailer::Base
  include ApplicationHelper

  def upcoming_geohashes(user, start_time)
    subject    "Geohashing adventures [#{geohashing_dates(user, start_time)}]"
    recipients user.email
    from       'activegeohasher@googlemail.com'
    sent_on    Time.now
    
    body       :user => user, :start_time => start_time
  end

  private

  def geohashing_dates(user, start_time)
    user.new_geohashes_since(start_time).keys.map{|date| short_date(date)}.join(', ')
  end

end

