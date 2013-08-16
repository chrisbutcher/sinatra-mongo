# http://recipes.sinatrarb.com/p/databases/mongo?#article
# http://128bitstudios.com/2012/03/03/mongomapper-with-sinatra-example/
# http://mongomapper.com/documentation/getting-started/sinatra.html

require 'rubygems'
require 'sinatra'
require 'mongo_mapper'

configure do
  MongoMapper.database = 'books'
end

class Book
  include MongoMapper::Document
  key :title, String
  key :author, String
end

get '/' do
  "Hello, world!"
end

get '/books' do
  @books = Book.all
  erb :books
end

get '/books/add' do
  erb :add_book
end

post "/books/create" do
  @new_book = Book.new(:title=>params[:title], :author=>params[:author])
  @new_book.save

  redirect "/books"
end