require 'sinatra'
require 'oauth'

YOUR_CONSUMER_KEY = ENV["CONSUMER_KEY"]
YOUR_CONSUMER_SECRET = ENV["CONSUMER_SECRET"]
def oauth_consumer
  return OAuth::Consumer.new(YOUR_CONSUMER_KEY, YOUR_CONSUMER_SECRET, :site => "https://www.healthplanet.jp/oauth/auth")
end

get '/' do
  erb :index
end

get '/healthplanet/auth' do
  callback_url = "http://localhost:4567/healthplanet/callback"
  request_token = oauth_consumer.get_request_token(:oauth_callback => callback_url)

  session[:request_token] = request_token
  session[:request_token_secret] = request_token.secret
  redirect request_token.authorize_url
  #"test"
end

