class Notifier < ActionMailer::Base

  def upcoming_geohashes(user, sent_at = Time.now)
    subject    'Notifier#upcoming_geohashes'
    recipients user.email
    from       ''
    sent_on    sent_at
    
    body       :user => user, :date => sent_at
  end

end
