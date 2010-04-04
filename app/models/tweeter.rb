require 'twitter_oauth'
class Tweeter < TwitterOAuth::Client

  def initialize
    super(
      :consumer_key => ENV['TWITTER_OAUTH_CONSUMER_KEY'],
      :consumer_secret => ENV['TWITTER_OAUTH_CONSUMER_SECRET'],
      :token => ENV['TWITTER_OAUTH_TOKEN'],
      :secret => ENV['TWITTER_OAUTH_SECRET'])
  end

  def deliver_upcoming_geohashes(user, start_time)
    user.new_geohashes_since(start_time).each do |date, geohashes|
      msg = date.strftime('%a').upcase + ' '
      geohashes.each do |geohash|
        msg += geohash.short_coordinates + '='
        msg += geohash.short_place_name_display + '. '
      end
      msg = msg[0..137] + '..' if msg.length > 140
      message(user.twitter_username, msg)
    end
  end

end
