require 'rspec'
require 'pg'
require 'book'
require 'patron'
require 'pry'

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM specialty *;")
  end
end
