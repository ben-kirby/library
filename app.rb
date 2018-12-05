require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/author')
require('./lib/book')
require('./lib/patron')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

get '/' do

  erb(:index)
end

get '/book_management' do

  erb(:book_management)
end
