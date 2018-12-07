require('pg')
require('pry')

class Author
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id).to_i
  end

  def self.all
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each do |each|
      name = each.fetch("name")
      id = each.fetch("id").to_i()
      authors.push(Author.new({:name => name, :id => id}))
    end
    return authors
  end

  def ==(another_author)
    self.name().==(another_author.name()).&(self.id().==(another_author.id()))
  end

  def save
    all_authors = Author.all
    all_authors.each do |author|
      if author.name == self.name
        return author.id
      end
    end
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
    return @id
  end

  def self.find(id)
    returned_authors = DB.exec("SELECT * FROM authors WHERE id = #{id};")
    returned_authors.each() do |author|
      name = author.fetch("name")
      id = author.fetch("id").to_i()
      return Author.new({:name => name, :id => id})
    end
  end

  def self.find_by_name(name)
    found_authors = []
    all_authors = Book.books_authors
    all_authors.each do |each|
      if each.fetch('name') == name
        found_authors.push(each)
      end
    end
    return found_authors
  end

end
