module GeohashCalculator

  require 'digest/md5'
  require 'date'
  require 'net/http'
  require 'bigdecimal'
  require 'timeout'
  
  def self.dow_for(date)
    timeout(10) do
      dow = Net::HTTP.start('irc.peeron.com', 80) do |http|
        http.get("/xkcd/map/data/#{date.strftime('%Y/%m/%d')}").body
      end
    end
    return nil if dow =~ /Not Found/
    return dow
  rescue Timeout::Error
    return nil
  end
  
  def self.md5_for(date, dow)
    Digest::MD5.hexdigest("#{date.strftime('%Y-%m-%d')}-#{dow}")
  end

  def self.coordinates_for(md5)
    [self.hex_fraction_to_decimal(md5[0..15]), self.hex_fraction_to_decimal(md5[16..31])]
  end

  def self.hex_fraction_to_decimal(hex_fraction)
    hex_fraction.to_i(16) / BigDecimal.new((16**(hex_fraction.length)).to_s)
  end
  
end

