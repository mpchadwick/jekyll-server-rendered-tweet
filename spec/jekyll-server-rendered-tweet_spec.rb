require 'twitter'

RSpec.describe Jekyll::ServerRenderedTweet do
  let(:renderer) { described_class.new("tweet", "1260001466292592641") }
  let(:tweet) {Twitter::Tweet.new({:id => "123"})}

  it "has a version number" do
    expect(Jekyll::ServerRenderedTweet::VERSION).not_to be nil
  end

  it "converts a tweet to html" do
    client = double("client")
    tweet.user.screen_name = 'bugbounty99'
    tweet.user.name = 'bugbounty99'
    tweet.user.profile_image_url_https = 'https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png'
  end
end
