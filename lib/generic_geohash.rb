module GenericGeohash

  def google_link
    "http://maps.google.com/maps?q=loc:#{lat},#{lng}(#{CGI::escape(google_maps_label)})&z=8&iwloc=A"
  end

  def bing_link
    "http://www.bing.com/maps/?v=2&where1=#{lat}%2C%20#{lng}&encType=1"
  end
  
  def osm_link
    "http://www.openstreetmap.org/index.html?mlat=#{lat}&mlon=#{lng}"
  end

  def geocaching_link
    "http://www.geocaching.com/seek/nearest.aspx?origin_lat=#{lat}&origin_long=#{lng}&dist=3"
  end

  def place_name_display
    return '[unknown location]' if place_name.blank?
    place_name
  end
  
  def google_map(request, zoomlevel=12, maptype='roadmap')
    returning String.new do |str|
      str << "http://maps.google.com/staticmap"
      str << "?size=300x200"
      str << "&center=#{lat},#{lng}"
      str << "&markers=#{lat},#{lng}"
      str << "&zoom=#{zoomlevel}"
      str << "&maptype=#{maptype}"
      str << "&key=#{GOOGLE_MAPS_API_KEY[request.host]}"
      str << "&sensor=false"
    end
  end

  def latitude_display
    lat.round(5).to_s
  end
  
  def longitude_display
    lng.round(5).to_s
  end

  def latitude_longitude_display
    "#{latitude_display}, #{longitude_display}"
  end

end
