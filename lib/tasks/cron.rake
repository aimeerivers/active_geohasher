desc 'Run the hourly cron tasks'
task :cron => :environment do
  current_time = Time.now.in_time_zone('Eastern Time (US & Canada)')
  puts current_time.inspect
  case current_time.hour
  when 7 then system 'rake geohashing:find_graticule_names'
  when 9 then system 'rake geohashing:deliver_notifications'
  else puts 'Nothing to do right now.'
  end
end

