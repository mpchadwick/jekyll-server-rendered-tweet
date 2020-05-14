require 'twitter'

RSpec.describe Jekyll::ServerRenderedTweet do
  let(:tweet) {Twitter::Tweet.new({
    :id => "123",
    :text => 'COVID-19 is, deservedly, the top news story right now. But...don\'t forget to respond to the Census!',
    :created_at => '2020-03-17 00:51:51 UTC',
    :favorite_count => 2
  })}

  it "has a version number" do
    expect(Jekyll::ServerRenderedTweet::VERSION).not_to be nil
  end

  it "converts a tweet to html" do
    client = double("client")
    tweet.user.screen_name = 'Max Chadwick'
    tweet.user.name = 'maxpchadwick'
    tweet.user.profile_image_url_https = 'https://pbs.twimg.com/profile_images/821919775429275648/JDEa0PC__normal.jpg'
    allow(client).to receive(:status).and_return(tweet)

    result = Jekyll::ServerRenderedTweet.render_tweet("1260001466292592641", client)
  end
end
