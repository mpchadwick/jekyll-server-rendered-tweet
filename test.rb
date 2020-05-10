require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

tweet = client.status(1249062128058843139)
puts tweet.text
puts tweet.user.screen_name
puts tweet.user.name
puts tweet.user.profile_image_uri
puts tweet.favorite_count
puts tweet.created_at
