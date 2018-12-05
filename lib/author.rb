require('pg')
require('pry')

class Author
  attr_accessor :name

  def initialize(attributes)
    @name
  end

  def self.all
    returned_authors = DB
  end

  def ==(another_author)
    self.author().==(another_author.author()).&(self.id().==(another_author.id()))
  end
end
