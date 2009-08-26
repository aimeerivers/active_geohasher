#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '../../config/environment.rb')

namespace :geohashing do
  desc "Attempt to deliver a single email to find out if it's working"
  task :test_email do
    Notifier.deliver_upcoming_geohashes(User.first, Time.now)
  end
end

