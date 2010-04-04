require 'spec_helper'

describe GenericGeohash do
  describe 'short_place_name_display' do
    it 'is a question mark if there is no place' do
      geohash = Geohash.new
      geohash.short_place_name_display.should == '?'
    end

    it 'removes extra vowels' do
      geohash = Geohash.new :place_name => 'Wootton'
      geohash.short_place_name_display.should == 'Woton'
    end

    it 'removes dots and commas' do
      geohash = Geohash.new :place_name => 'Winchester, UK.'
      geohash.short_place_name_display.should == 'Winchester UK'
    end

    it 'limits to 25 characters' do
      geohash = Geohash.new :place_name => 'Rookery Ave, Hampshire PO15 7, UK '
      geohash.short_place_name_display.should == 'Rokery Ave Hampshire PO15'
    end

    it 'removes spaces from the end' do
      geohash = Geohash.new :place_name => 'Rookery Ave, Hampshire PO1  7, UK '
      geohash.short_place_name_display.should == 'Rokery Ave Hampshire PO1'
    end
  end

  describe 'short coordinates' do
    it 'rounds the lat and lng to 3 decimal places' do
      geohash = Geohash.new :lat => 50.8796674722457, :lng => -0.2561087985562
      geohash.short_coordinates.should == '50.88,-0.256'
    end
  end
end
