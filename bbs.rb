require 'sinatra'
require 'active_record'

set :environment, :production

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection :development

class Post < ActiveRecord::Base
end

helpers do
    include Rack::Utils
    alias_method :h,:escape_html
end

get '/' do
  @posts = Post.all
  erb :index
end

post '/' do
  username = Rack::Utils.escape_html(params[:user_name]) || "No Name"
  message  = Rack::Utils.escape_html(params[:mess])
  Post.create(message: message, posted_at: Time.now, user_name: username)
  redirect '/'
end

delete '/' do
  post = Post.find(params[:id])
  post.destroy
  redirect '/'
end
