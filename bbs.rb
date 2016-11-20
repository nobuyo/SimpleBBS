require 'sinatra'
require 'active_record'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection :development

class Post < ActiveRecord::Base
end

get '/' do
end

post '/' do
end

delete '/' do
end