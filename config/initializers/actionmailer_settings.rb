ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true, 
  :address => "smtp.gmail.com", 
  :port => "587",
  :domain => "gmail.com",
  :authentication => :plain,
  :user_name => ENV['EMAIL_USER_NAME'],
  :password => ENV['EMAIL_PASSWORD'] 
}

