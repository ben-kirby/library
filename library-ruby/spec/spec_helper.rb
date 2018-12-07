require 'rspec'
require 'pg'
require 'book'
require 'patron'
require 'author'
require 'pry'
require 'date'
require 'checkout'

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    # DB.exec("DELETE FROM authors *;")
    DB.exec("TRUNCATE authors * RESTART IDENTITY")
    DB.exec("INSERT INTO authors (name) VALUES ('Unknown')")

    # DB.exec("DELETE FROM patrons *;")
    DB.exec("TRUNCATE patrons * RESTART IDENTITY")
    DB.exec("INSERT INTO patrons (name) VALUES ('Unknown')")

    # DB.exec("DELETE FROM books *;")
    DB.exec("TRUNCATE books * RESTART IDENTITY")
    DB.exec("INSERT INTO books (title, author_id) VALUES ('Unknown', 1)")

    # DB.exec("DELETE FROM checkouts *;")
    DB.exec("TRUNCATE checkouts * RESTART IDENTITY")

  end
end
