require 'open-uri'

pdf.text "xkcd geohashing", :style => :bold, :size => 24

pdf.move_down(24)

pdf.text "The internet was here!", :style => :italic, :size => 18

pdf.move_down(24)

pdf.font_size 12 do
  pdf.text "Specifically, some geohashers were at the geographic point"
  pdf.text "Latitude #{@geohash.latitude_display}, Longitude #{@geohash.longitude_display}", :style => :italic
  pdf.text "in #{@geohash.place_name_display}", :style => :bold
  pdf.text "on #{friendly_date(@geohash.date)}."

  pdf.move_down(12)

  pdf.text "To find out why, visit"
  pdf.text pretty_geohash_url(@geohash.date, @geohash.graticule_latitude, @geohash.graticule_longitude), :size => 14
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
