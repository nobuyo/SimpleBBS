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
  if username.empty?
    username = "No Name"
  end
  if username.length >= 30
    username = username[0,29] + "..."
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
