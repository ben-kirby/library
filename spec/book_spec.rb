require 'spec_helper'

describe(Book) do
  describe('.all') do
    it("should return all instances in an array") do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("should return an empty array when nothing is passed in") do
      new_book = Book.new({:title => "Harry Potter & The Sorcerers Stone", :author_id => "J.K. Rawling", :id => nil})
      new_book.save()
      expect(Book.all).to(eq([new_book]))
    end
  end

  describe('#find') do
    it("should find a specific record given an id") do
      new_book = Book.new({:title => "Harry Potter & The Sorcerers Stone", :author_id => "J.K. Rawling", :id => nil})
      new_book.save()
      new_book2 = Book.new({:title => "Fellowship of the Ring", :author_id => "J.R.R. Tolken", :id => nil})
      new_book2.save()
      expect(Book.find(new_book2.id)).to(eq(new_book2))
    end
  end

end
