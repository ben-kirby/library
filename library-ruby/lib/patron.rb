require('pg')
require('pry')

class Patron
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id =  attributes.fetch(:id)
  end

  def self.all
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each do |each|
      name = each.fetch("name")
      id = each.fetch("id").to_i()
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    return patrons
  end

  def ==(another_patron)
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end

  def save
    # specialty_id = Specialty.new(@specialty)
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(id)
    returned_patrons = DB.exec("SELECT * FROM patrons WHERE id = #{id};")
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i()
      return Patron.new({:name => name, :id => id})
    end
  end

end
