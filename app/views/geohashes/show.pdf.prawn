require 'open-uri'

pdf.image open("http://qrcode.kaywa.com/img.php?s=6&d=#{pretty_geohash_url(@geohash.date, @geohash.graticule_latitude, @geohash.graticule_longitude)}"), :width => 130, :position => :right

pdf.move_up 120

pdf.text "xkcd geohashing", :style => :bold, :size => 24

pdf.move_down 10

pdf.text "The internet was here!", :style => :italic, :size => 18

pdf.move_down 20

pdf.font_size 12 do
  pdf.text "Specifically, some geohashers"
  pdf.text "were at the geographic point"
  pdf.text "Latitude #{@geohash.latitude_display}, Longitude #{@geohash.longitude_display}", :style => :italic
  pdf.text "on #{friendly_date(@geohash.date)}."
  pdf.text @geohash.place_name_display, :style => :bold

  pdf.move_down(12)

  pdf.text "To find out why, visit #{pretty_geohash_url(@geohash.date, @geohash.graticule_latitude, @geohash.graticule_longitude)}"
end

pdf.move_down(24)

pdf.image open(@geohash.coordinate_calculation_image), :width => 410

pdf.image open(URI.escape(@geohash.google_map_with_graticule(request) + '&format=png')), :width => 200

pdf.move_down(24)

pdf.font_size 12 do
  pdf.text "Geohashing is an adventure game."
  pdf.text "An algorithm generates random coordinates daily, and people try to get there to see new places, meet new people, and have fun doing it."

  pdf.move_down(12)

  pdf.text "To find out more or get involved, visit"
  pdf.text "http://geohashing.org", :size => 14
end
