require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/author')
require('./lib/book')
require('./lib/patron')
require('pry')

DB = PG.connect({:dbname => 'library'})

get '/' do

  erb(:index)
end

get '/book_management' do
  @books = Book.all
  @authors = Author.all
  erb(:book_management)
end

post '/book_management' do
  title = params.fetch('title')
  author_id = params.fetch('author')
  # find_author = Author.find_by_name(author)
  # binding.pry




  new_book = Book.new({:title => title, :author_id => author_id, :id => nil})
  new_book.save()

  @books = Book.all
  @authors = Author.all

  erb(:book_management)
end
