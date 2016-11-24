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
  Post.create(message: params[:mess], posted_at: Time.now, user_name: params[:user_name])
  redirect '/'
end

delete '/' do
  post = Post.find(params[:id])
  post.destroy
  redirect '/'
end
