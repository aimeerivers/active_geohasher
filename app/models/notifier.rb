class Notifier < ActionMailer::Base

  def upcoming_geohashes(user, start_time)
    subject    'Geohashing adventures for you!'
    recipients user.email
    from       'activegeohasher@googlemail.com'
    sent_on    Time.now
    
    body       :user => user, :start_time => start_time
  end

end

