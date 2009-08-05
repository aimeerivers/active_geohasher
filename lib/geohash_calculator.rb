module GeohashCalculator

  require 'digest/md5'
  require 'date'
  require 'net/http'
  require 'bigdecimal'
  
  def self.dow_for(date)
    dow = Net::HTTP.start('irc.peeron.com', 80) do |http|
      http.get("/xkcd/map/data/#{date.strftime('%Y/%m/%d')}").body
    end
    return nil if dow =~ /Not Found/
    dow
  end
  
  def self.md5_for(date, dow)
    Digest::MD5.hexdigest("#{date.strftime('%Y-%m-%d')}-#{dow}")
  end

  def self.coordinates_for(md5)
    [self.hex_fraction_to_decimal(md5[0..15]), self.hex_fraction_to_decimal(md5[16..31])]
  end

  def self.hex_fraction_to_decimal(hex_fraction)
    power = 0
    hex_fraction.each_char.inject(0) {|sum, char| sum + (char.to_i(16) * (1.0/(16**(power+=1)))) }
  end

  def self.hex_fraction_to_super_accurate_decimal(hex_fraction)
    power = 0
    hex_fraction.each_char.inject(0) {|sum, char| sum + (char.to_i(16) * (BigDecimal.new('1')/BigDecimal.new((16**(power+=1)).to_s))) }
  end
  
end

