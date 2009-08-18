class Notifier < ActionMailer::Base

  def upcoming_geohashes(user, start_time)
    subject    'Notifier#upcoming_geohashes'
    recipients user.email
    from       ''
    sent_on    Time.now
    
    body       :user => user, :start_time => start_time
  end

end

