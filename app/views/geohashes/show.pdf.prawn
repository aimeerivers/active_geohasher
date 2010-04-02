require 'open-uri'

pdf.image open("http://qrcode.kaywa.com/img.php?s=6&d=#{@geohash.wiki_link}"), :width => 140, :position => :right

pdf.move_up 125

pdf.text "xkcd geohashing", :style => :bold, :size => 24
pdf.move_down 5
pdf.text "The internet was here!", :style => :italic, :size => 18

pdf.move_down 10
pdf.font_size 12 do
  pdf.text "Specifically, some geohashers"
  pdf.text "were at the geographic coordinates"
  pdf.text @geohash.latitude_longitude_display, :style => :italic
  pdf.text "on #{friendly_date(@geohash.date)}."
end

pdf.move_down 15
pdf.text @geohash.place_name_display, :style => :bold, :size => 12
pdf.move_down 5
pdf.image open(URI.escape(@geohash.google_map(request, 11))), :height => 133, :position => :left
pdf.move_up 133
pdf.image open(URI.escape(@geohash.google_map(request, 17, 'hybrid'))), :height => 133, :position => :right

pdf.move_down 20
pdf.font_size 12 do
  pdf.text "Geohashing is an adventure game."
  pdf.text "An algorithm generates random coordinates daily, and people try to get there to see new places, meet new people, and have fun doing it."
  pdf.text "To find out more or join in the fun yourself, visit http://geohashing.org"
end

pdf.move_down 20
pdf.text "How this geohash location was calculated", :style => :bold, :size => 12
pdf.move_down 5
pdf.image open(@geohash.coordinate_calculation_image), :width => 410

pdf.move_down 20
pdf.font_size 12 do
  pdf.text "Now that you've seen this poster, we'd love to hear from you."
  pdf.text "The place to talk about this particular expedition is at"
  pdf.text @geohash.wiki_link, :style => :bold
  pdf.text "Come and say hello and tell us how you came to find the poster!"
end
