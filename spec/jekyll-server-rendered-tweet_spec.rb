RSpec.describe Jekyll::ServerRenderedTweet do

  class Tweet
    attr_accessor :text, :created_at, :favorite_count, :user
  end

  class User
    attr_accessor :screen_name, :name, :profile_image_url_https
  end

  let (:user) { User.new }

  let(:tweet) { Tweet.new }

  it "has a version number" do
    expect(Jekyll::ServerRenderedTweet::VERSION).not_to be nil
  end

  it "converts a tweet to html" do
    user.screen_name = 'maxpchadwick'
    user.name = 'Max Chadwick'
    user.profile_image_url_https = 'https://pbs.twimg.com/profile_images/821919775429275648/JDEa0PC__normal.jpg'
    tweet.text = 'COVID-19 is, deservedly, the top news story right now. But...don\'t forget to respond to the Census!'
    tweet.created_at = DateTime.parse('2020-03-17 00:51:51 UTC')
    tweet.favorite_count = 2
    tweet.user = user
    client = double("client")

    allow(client).to receive(:status).and_return(tweet)

    result = Jekyll::ServerRenderedTweet.render_tweet("1239716041774837765", client)
    expected = File.read(File.dirname(__FILE__) + '/fixtures/1239716041774837765.html')

    expect(result).to include(expected)
  end
end
