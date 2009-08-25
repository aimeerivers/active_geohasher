#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '../../config/environment.rb')

namespace :geohashing do
  desc "Look up missing graticule names"
  task :find_graticule_names do
    puts "Looking for graticules without names"
    Graticule.without_names.each do |graticule|
      puts "Processing #{graticule.latitude}, #{graticule.longitude} ... "
      name = graticule.get_name_from_geohashing_wiki
      puts name
    end
  end
end

