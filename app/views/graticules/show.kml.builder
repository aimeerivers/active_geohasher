xml.instruct!
xml.kml(:xmlns => "http://earth.google.com/kml/2.2") {
  xml.Document {
    xml.name "#{@graticule.display_name} geohashes"
    xml.open(1)
    xml.visible(1)
    xml.NetworkLink {
      xml.name "Latest geohash locations ..."
      xml.open(1)
      xml.visibility(1)
      xml.Link {
        xml.href geohashes_graticule_url(@graticule, :format => :kml)
        xml.refreshMode('onInterval')
        xml.refreshInterval(3600)
      }
    }
  }
}

