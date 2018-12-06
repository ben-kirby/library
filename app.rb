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
  erb(:book_management)
end

post '/book_management' do
  title = params.fetch('title')
  author = params.fetch('author')
  author.new(author)
  author_id = author.save

  # find_author = Author.find_by_name(author)
  # binding.pry




  new_book = Book.new({:title => title, :author_id => author_id, :id => nil})
  new_book.save()

  @books = Book.all
  erb(:book_management)
end

get '/author_management' do
  @authors = Author.all()
  erb(:author_management)
end

post '/author_management' do
  name = params.fetch('name')

  new_author = Author.new({:name => name, :id => nil})
  new_author.save()

  @authors = Author.all
  erb(:author_management)
end

get '/patron_management' do
  @patrons = Patron.all
  erb(:patron_management)
end

post '/patron_management' do
  name = params.fetch('name')

  new_patron = Patron.new({:name => name, :id => nil})
  new_patron.save()

  @patrons = Patron.all
  erb(:patron_management)
end

get '/checkout' do
  @patrons = Patron.all
  @books = Book.all

  erb(:checkout)
end
