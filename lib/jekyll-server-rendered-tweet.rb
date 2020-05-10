require "jekyll"

module Jekyll

  class ServerRenderedTweet < Liquid::Tag
	  def initialize(tag_name, text, tokens)
	  	super
	  	@text = text
	  end

	  def render(context)
      @template = Liquid::Template::parse(
        File.read(File.join(File.dirname(__FILE__), 'tweet.liquid'))
      )

      @template.render()
	  end

  end
end

Liquid::Template.register_tag("tweet", Jekyll::ServerRenderedTweet)
