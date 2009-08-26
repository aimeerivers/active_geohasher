desc 'Run the hourly cron tasks'
task :cron => :environment do
  case Time.now.in_time_zone('Eastern Time (US & Canada)').hour
  when 8 then system 'rake geohashing:find_graticule_names'
  when 10 then system 'rake geohashing:deliver_notifications'
  else puts 'nothing'
  end
end

