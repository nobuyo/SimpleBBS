require 'sinatra'
require 'active_record'

set :environment, :production

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection :development

class Post < ActiveRecord::Base
end

get '/' do
  @posts = Post.all
  erb :index
end

post '/' do
  username = Rack::Utils.escape_html(params[:user_name])
  if username.nil?
    username = "NoName"
  end
  message  = Rack::Utils.escape_html(params[:mess])
  Post.create(message: message, posted_at: Time.now, user_name: username)
  redirect '/'
end

delete '/' do
  post = Post.find(params[:id])
  post.destroy
  redirect '/'
end
