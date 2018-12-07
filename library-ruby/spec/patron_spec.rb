require 'spec_helper'

describe(Patron) do
  describe('.all') do
    it("should return all instances in an array") do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("should return an empty array when nothing is passed in") do
      new_patron = Patron.new({:name => "R.K. Rowling", :id => nil})
      new_patron.save()
      expect(Patron.all).to(eq([new_patron]))
    end
  end

  describe('#find') do
    it("should find a specific record given an id") do
      new_patron = Patron.new({:name => "R.K. Rowling", :id => nil})
      new_patron.save()
      new_patron2 = Patron.new({:name => "J.R.R. Tolken", :id => nil})
      new_patron2.save()
      expect(Patron.find(new_patron2.id)).to(eq(new_patron2))
    end
  end

end
