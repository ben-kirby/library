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
      author_id = each.fetch("author_id")
      id = each.fetch("id").to_i()
      books.push(Book.new({:title => title, :author_id => author_id, :id => id}))
    end
    return books
  end

  def save
    all_books = Books.all
    all_books.each do |each|
      if each.name == self.name
        return each.book_id
      end
    end
    result = DB.exec("INSERT INTO books (title, author_id) VALUES ('#{@title}', '#{@author_id}') RETURNING book_id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(id)
    returned_books = DB.exec("SELECT * FROM books WHERE id = #{id};")
    returned_books.each() do |book|
      title = book.fetch("title")
      author_id = book.fetch("author_id")
      id = book.fetch("id").to_i()
      return Book.new({:title => title, :author_id => author_id, :id => id})
    end
  end

  def self.books_authors
    all_books = DB.exec("SELECT * FROM books JOIN authors ON (authors.id = books.author_id);")
  end

  def self.find_by_title(title)
    found_books = []
    all_books = Book.books_authors
    all_books.each do |each|
      if each.title == title
        found_books.push(each)
      end
    end
    return found_books
  end

end
