xml.instruct!
xml.kml(:xmlns => "http://earth.google.com/kml/2.2") {
  xml.Document {
    xml.name "#{@graticule.name} geohashes"
    @graticule.geohashes.new_since(1.day.ago).each do |geohash|
      xml.Placemark {
        xml.description geohash.description
        xml.name geohash.place_name_display
        xml.LookAt {
          xml.longitude geohash.longitude_display
          xml.latitude geohash.latitude_display
          xml.altitude 1000
          xml.altitudeMode 'relativeToGround'
        }
        xml.Point {
          xml.coordinates("#{geohash.longitude_display},#{geohash.latitude_display},0")
        }
      }
    end
  }
}

