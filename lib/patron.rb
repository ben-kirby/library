require('pg')
require('pry')

class Patron
  attr_accessor :name

  def initialize(attributes)
    @name
  end

  def ==(another_patron)
    self.patron().==(another_patron.patron()).&(self.id().==(another_patron.id()))
  end
end
