# http://recipes.sinatrarb.com/p/databases/mongo?#article

require 'rubygems'
require 'sinatra'
require 'mongo'
require 'json/ext' # required for .to_json

include Mongo

configure do
  conn = MongoClient.new("localhost", 27017)
  set :mongo_connection, conn
  set :mongo_db, conn.db('books')
end

helpers do
  def object_id val
    BSON::ObjectId.from_string(val)
  end

  def document_by_id id
    id = object_id(id) if String === id
    settings.mongo_db['books'].find_one(:_id => id).to_json
  end
end

get '/' do
  "Hello, world!"
end

get '/books/all' do
  # content_type :json
  @books = settings.mongo_db['books'].find({}, :sort => 'title')
  erb :books
end