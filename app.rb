require 'sinatra'
require 'slim'
require 'httparty'

$subs = ["css", "frontend", "ruby", "tmux", "usability", "vim", "web", "web_design", "webdev"]

def multiNews
	response = HTTParty.get('http://www.reddit.com/user/pibby_/m/webdev/.json')
	obj = JSON.parse(response.body)
	@items = obj["data"]["children"]
end

def fetchNews(subreddit)
	response = HTTParty.get('http://www.reddit.com/r/'+subreddit+'/.json')
	obj = JSON.parse(response.body)
	@items = obj["data"]["children"]
end

get '/' do
	multiNews
	@subtitle = "Front-End Multi"
	slim :index
end

$subs.each do |sub|
	get "/#{sub}" do
		fetchNews("#{sub}")
		@subtitle = "#{sub}"
		slim :index
	end
end