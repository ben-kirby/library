require('pg')
require('pry')

class Book
  attr_accessor :title, :author_id, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @author_id = attributes.fetch(:author_id)
    @id = attributes.fetch(:id)
  end

  def ==(another_book)
    self.title().==(another_book.title()).&(self.id().==(another_book.id()))
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each do |each|
      title = each.fetch("title")
      author_id = each.fetch("author_id").to_i()
      id = each.fetch("id").to_i()
      books.push(Book.new({:title => title, :author_id => author_id, :id => id}))
    end
    return books
  end

  def save
    # specialty_id = Specialty.new(@specialty)
    result = DB.exec("INSERT INTO books (title, author_id) VALUES ('#{@title}', '#{@author_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(id)
    returned_books = DB.exec("SELECT * FROM books WHERE id = #{id};")
    returned_books.each() do |book|
      title = book.fetch("title")
      author_id = book.fetch("author_id").to_i()
      id = book.fetch("id").to_i()
      return Book.new({:title => title, :author_id => author_id, :id => id})
    end
  end

end
