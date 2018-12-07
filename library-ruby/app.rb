require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/author')
require('./lib/book')
require('./lib/patron')
require('pry')
require('./lib/checkout')

DB = PG.connect({:dbname => 'library'})

get '/' do

  erb(:index)
end

get '/book_management' do
  @books = Book.books_authors
  erb(:book_management)
end

post '/book_management' do
  title = params.fetch('title')
  author = params.fetch('author')
  new_author = Author.new({:name => author, :id => nil})
  author_id = new_author.save
  new_book = Book.new({:title => title, :author_id => author_id, :id => nil})
  new_book.save
  @books = Book.books_authors
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

  @books = Book.books_authors
end

get '/checkout' do
  @patrons = Patron.all
  @books = Book.books_authors

  erb(:checkout)
end

post '/checkout' do
  patron_id = params.fetch("patron").to_i
  book_id = params.fetch("book").to_i
  new_checkout = Checkout.new({:book_id => book_id, :patron_id => patron_id, :due_date => nil, :checkout_date => nil, :out => nil, :id => nil})
  new_checkout.save

  @patrons = Patron.all
  @books = Book.books_authors
  @checkouts = Checkout.all

erb(:checkout)
end

get '/history' do
  @patrons = Patron.all
  @books = Book.books_authors
  @checkouts = Checkout.all
  erb(:history)
end

post '/history' do
  patron_id = params.fetch("patron").to_i
  @patrons = Patron.all
  @books = Book.books_authors
  @checkouts = Checkout.all

  @found_checkouts = Checkout.find_by_patron(patron_id)
  # binding.pry
  erb(:history)
end

get '/book_search' do
  erb(:book_search)
end

post '/book_search' do
  search_term = params.fetch("search")
  selection = params.fetch("type")
  if selection == "title"
    @found_works = Book.find_by_title(search_term)
  else
    @found_works = Author.find_by_name(search_term)
  end

  @found_works

  erb(:book_search)
end
