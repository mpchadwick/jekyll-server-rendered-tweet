require 'jekyll'
require 'twitter'

module Jekyll
  class ServerRenderedTweet < Liquid::Tag
    attr_writer :client

    def initialize(tag_name, text, tokens)
      super
      @client = nil
      @text = text.strip
    end

    def render(_context)
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
      ServerRenderedTweet.render_tweet(@text, @client)
    end

    def self.render_tweet(tweet_id, client)
      tweet = client.status(tweet_id, tweet_mode: 'extended')

      @template = Liquid::Template.parse(
        File.read(File.join(File.dirname(__FILE__), 'tweet.liquid'))
      )

      @template.render(render_params(tweet_id, tweet))
    end

    def self.render_params(tweet_id, tweet)
      created_at = tweet.created_at.strftime('%l:%M %p - %b %e, %Y')

      params = {
        'tweet_id' => tweet_id,
        'user_screen_name' => tweet.user.screen_name,
        'user_name' => tweet.user.name,
        'user_profile_image_uri' => tweet.user.profile_image_url_https.to_s,
        'text' => tweet.text,
        'created_at_display' => created_at
      }

      if tweet.favorite_count.positive?
        params['favorite_count'] = tweet.favorite_count
      end

      params
    end

    private_class_method :render_params
  end
end

Liquid::Template.register_tag('tweet', Jekyll::ServerRenderedTweet)
