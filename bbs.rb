require 'sinatra'
require 'active_record'
require 'bcrypt'

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
  # treat username
  username = Rack::Utils.escape_html(params[:user_name])
  if username.empty?
    username = "No Name"
  end
  if username.length > 30
    username = username[0,29] + "..."
  end

  # encrypt password
  delete_key = params[:del_key]
  if delete_key.blank?
    delete_key = "0000"
  end
  password_salt = BCrypt::Engine.generate_salt
  password_hash = BCrypt::Engine.hash_secret(delete_key, password_salt)

  message  = Rack::Utils.escape_html(params[:mess])
  Post.create(message: message, posted_at: Time.now, user_name: username, hashed_delete_key: password_hash, salt: password_salt)
  redirect '/'
end

delete '/' do
  post = Post.find(params[:id])
  if post && post.hashed_delete_key == BCrypt::Engine.hash_secret(params[:del_key], post.salt)
    post.destroy
    # todo : flash
  end
  redirect '/'
end
