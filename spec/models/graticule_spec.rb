require 'spec_helper'

describe Graticule do
  def new_graticule(latitude, longitude)
    Graticule.new(:latitude => latitude, :longitude => longitude)
  end

  describe 'latitude north' do
    it 'is plus one in the northern hemisphere' do
      graticule = new_graticule('50', '-1')
      graticule.latitude_north.should == '51'
    end

    it 'is plus one in the southern hemisphere' do
      graticule = new_graticule('-32', '23')
      graticule.latitude_north.should == '-31'
    end

    it 'changes from negative one to negative zero' do
      graticule = new_graticule('-1', '29')
      graticule.latitude_north.should == '-0'
    end

    it 'changes from negative zero to zero' do
      graticule = new_graticule('-0', '29')
      graticule.latitude_north.should == '0'
    end

    it 'does not go any further than the north pole' do
      graticule = new_graticule('89', '-144')
      graticule.latitude_north.should == '89'
    end
  end

  describe 'latitude south' do
    it 'is minus one in the northern hemisphere' do
      graticule = new_graticule('33', '89')
      graticule.latitude_south.should == '32'
    end

    it 'is minus one in the southern hemisphere' do
      graticule = new_graticule('-27', '139')
      graticule.latitude_south.should == '-28'
    end

    it 'changes from zero to negative zero' do
      graticule = new_graticule('0', '38')
      graticule.latitude_south.should == '-0'
    end

    it 'changes from negative zero to negative one' do
      graticule = new_graticule('-0', '38')
      graticule.latitude_south.should == '-1'
    end

    it 'does not go any further than the south pole' do
      graticule = new_graticule('-89', '-144')
      graticule.latitude_south.should == '-89'
    end
  end

  describe 'longitude east' do
    it 'is plus one in the eastern hemisphere' do
      graticule = new_graticule('21', '78')
      graticule.longitude_east.should == '79'
    end

    it 'is plus one in the western hemisphere' do
      graticule = new_graticule('42', '-76')
      graticule.longitude_east.should == '-75'
    end

    it 'changes from negative one to negative zero' do
      graticule = new_graticule('38', '-1')
      graticule.longitude_east.should == '-0'
    end

    it 'changes from negative zero to zero' do
      graticule = new_graticule('43', '-0')
      graticule.longitude_east.should == '0'
    end

    it 'changes from positive 179 to negative 179' do
      graticule = new_graticule('-16', '179')
      graticule.longitude_east.should == '-179'
    end
  end

  describe 'longitude west' do
    it 'is minus one in the eastern hemisphere' do
      graticule = new_graticule('52', '13')
      graticule.longitude_west.should == '12'
    end

    it 'is minus one in the western hemisphere' do
      graticule = new_graticule('-11', '-75')
      graticule.longitude_west.should == '-76'
    end

    it 'changes from zero to negative zero' do
      graticule = new_graticule('51', '0')
      graticule.longitude_west.should == '-0'
    end

    it 'changes from negative zero to negative one' do
      graticule = new_graticule('8', '-0')
      graticule.longitude_west.should == '-1'
    end

    it 'changes from negative 179 to positive 179' do
      graticule = new_graticule('66', '-179')
      graticule.longitude_west.should == '179'
    end
  end
end
