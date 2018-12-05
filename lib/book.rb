require('pg')
require('pry')

class Book
  attr_accessor :title, :author

  def initialize(attributes)
    @title
    @author
  end

  def ==(another_book)
    self.book().==(another_book.book()).&(self.id().==(another_book.id()))
  end
end
