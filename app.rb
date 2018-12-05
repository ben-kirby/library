require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/doctor')
require('./lib/patient')
require('./lib/specialty')
require('pry')

DB = PG.connect({:dbname => 'doctors_office_test'})
