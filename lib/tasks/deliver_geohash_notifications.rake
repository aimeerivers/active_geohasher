#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '../../config/environment.rb')

namespace :geohashing do
  desc "Find geohash locations and deliver notification emails"
  task :deliver_notifications do
    start_time = Time.now
    date = Date.today

    # Return early if today's dow has already been found (ie it's a weekend and notifications were delivered yesterday)
    if Dow.count(:all, :conditions => {:date => date.strftime('%Y-%m-%d')}) > 0
      puts "Dow already found for #{date.strftime('%Y-%m-%d')}"
      exit
    end

    # Look for today's dow value and keep looking until it is found
    # Must have at least one dow value to be worth continuing.
    dow_found = false
    while !dow_found do
      puts "Looking for dow for #{date.strftime('%Y-%m-%d')}"
      dow = Dow.find_or_create_for_date(date)
      if dow.nil?
        puts 'Waiting 15 minutes'
        sleep 15*60
      else
        dow_found = true
      end
    end

    # Check whether there are any other dow dates available already
    # These are optional extras for weekends and public holidays.
    dows = [dow]
    until dow.nil? do
      date += 1.day
      puts "Looking for optional extra dow for #{date.strftime('%Y-%m-%d')}"
      dow = Dow.find_or_create_for_date(date)
      if dow.nil?
        puts "Dow for #{date.strftime('%Y-%m-%d')} not yet available"
      else
        dows << dow
      end
    end

    # Find geohash locations for all known graticules on all dows found
    date_range = Range.new(dows.first.date, (dows.last.date + 1.day))
    date_range.each do |date|
      puts "Looking up geohash locations for #{date.strftime('%Y-%m-%d')}"
      Graticule.all.each do |graticule|
        puts "* #{graticule.display_name}"
        Geohash.find_or_create(date, graticule.latitude, graticule.longitude)
      end
    end

    # Send emails
    User.all.each do |user|
      next if user.graticules.size == 0
      puts "Delivering email to #{user.name}"
      Notifier.deliver_upcoming_geohashes(user, start_time)
    end
  end
end

