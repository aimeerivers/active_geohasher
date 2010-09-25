xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Geohash locations in #{@graticule.display_name}"
    xml.description "Upcoming geohash locations, brought to you by Active Geohasher"
    xml.link formatted_pretty_graticule_url(@graticule.latitude, @graticule.longitude, :rss)

    @graticule.geohashes.latest.each do |geohash|
      xml.item do
        xml.title "Geohash on #{geohash.description}"
        xml.description "The geohash for #{@graticule.latitude_longitude_display} on #{geohash.date} is at #{geohash.latitude_longitude_display} which turns out to be #{geohash.place_name_display}."
        xml.pubDate geohash.created_at.to_s(:rfc822)
        xml.link pretty_geohash_url(geohash.date, @graticule.latitude, @graticule.longitude)
      end
    end
  end
end
