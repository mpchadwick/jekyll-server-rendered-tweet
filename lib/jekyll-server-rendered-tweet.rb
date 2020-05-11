require 'jekyll'
require 'twitter'

module Jekyll

  class ServerRenderedTweet < Liquid::Tag

    attr_writer :client

	  def initialize(tag_name, text, tokens)
	  	super
      @client = nil
	  	@text = text
	  end

	  def render(context)
      render_tweet()
	  end

    def render_tweet()
      if @client == nil
        @client = Twitter::REST::Client.new do |config|
          config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
          config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
          config.access_token = ENV['TWITTER_ACCESS_TOKEN']
          config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
        end
      end

      #tweet = @client.status(@text)
      tweet = Marshal::load(
        File.open(File.join(
          File.dirname(__FILE__), '..', 'tweet.marshal'
        ), 'r')
      )

      @template = Liquid::Template::parse(
        File.read(File.join(File.dirname(__FILE__), 'tweet.liquid'))
      )
      @template.render(
        'tweet_id' => @text,
        'user_screen_name' => tweet.user.screen_name,
        'user_profile_image_uri' => tweet.user.profile_image_url_https.to_s
      )
    end

  end
end

Liquid::Template.register_tag("tweet", Jekyll::ServerRenderedTweet)
