require 'sinatra'

class TestApp < Sinatra::Base
  set :root, File.dirname(__FILE__)

  get '/ferry/secure/multi_price_detail.aspx' do
    send_file File.expand_path('get.html', TestApp.root)
  end

  post '/ferry/secure/multi_price_detail.aspx' do
    send_file File.expand_path('post.html', TestApp.root)
  end
end
