require 'open-uri'

pdf.image open("http://qrcode.kaywa.com/img.php?s=6&d=#{@geohash.wiki_link}"), :width => 140, :position => :right

pdf.move_up 125

pdf.text t('.poster.xkcd_geohashing'), :style => :bold, :size => 24
pdf.move_down 5
pdf.text t('.poster.the_internet_was_here'), :style => :italic, :size => 18

pdf.move_down 10
pdf.font_size 11 do
  pdf.text t('.poster.some_geohashers')
  pdf.text @geohash.latitude_longitude_display, :style => :italic
  pdf.text t('.poster.on_date', :date => l(@geohash.date, :format => :long))
end

pdf.move_down 15
pdf.text @geohash.place_name_display, :style => :bold, :size => 12
pdf.move_down 5
pdf.image open(URI.escape(@geohash.google_map(request, 11))), :height => 133, :position => :left
pdf.move_up 133
pdf.image open(URI.escape(@geohash.google_map(request, 17, 'hybrid'))), :height => 133, :position => :right

pdf.move_down 20
pdf.font_size 11 do
  pdf.text t('.poster.geohashing_is_an_adventure_game')
  pdf.text t('.poster.an_algorithm_generates_random_coordinates')
  pdf.text t('.poster.to_find_out_more', :link => 'http://geohashing.org')
end

pdf.move_down 20
pdf.text t('.poster.how_this_geohash_location_was_calculated'), :style => :bold, :size => 12
pdf.move_down 5
pdf.image open(@geohash.coordinate_calculation_image), :width => 410

pdf.move_down 20
pdf.font_size 11 do
  pdf.text t('.poster.now_that_you_have_seen_this_poster')
  pdf.text t('.poster.the_place_to_talk')
  pdf.text @geohash.wiki_link, :style => :bold
  pdf.text t('.poster.come_and_say_hello')
end
