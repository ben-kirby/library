require 'spec_helper'

describe(Author) do
  describe('.all') do
    it("should return all instances in an array") do
      temp_answer = Author.all()
      expect(Author.all()).to(eq(temp_answer))
    end
  end

  describe('#save') do
    it("should return an empty array when nothing is passed in") do
      new_author = Author.new({:name => "R.K. Rowling", :id => nil})
      new_author.save()
      expect(Author.all).to(eq([Author.new({:name => "Unknown", :id => 1}),new_author]))
    end
  end

  describe('#find') do
    it("should find a specific record given an id") do
      new_author = Author.new({:name => "R.K. Rowling", :id => nil})
      new_author.save()
      new_author2 = Author.new({:name => "J.R.R. Tolken", :id => nil})
      new_author2.save()
      expect(Author.find(new_author2.id)).to(eq(new_author2))
    end
  end

  describe('.find_by_name') do
    it("should find a specific record given a string name") do
      new_author = Author.new({:name => "R.K. Rowling", :id => nil})
      new_author.save()
      # binding.pry
      expect(Author.find_by_name("R.K. Rowling")).to(eq(["array of ?"]))
    end
  end

  # describe('.find_by_name') do
  #   it("should find a specific record given an id") do
  #     new_author = Author.new({:name => "R.K. Rowling", :id => nil})
  #     new_author.save()
  #     expect(Author.find_by_name("foo")).to(eq(new_author))
  #   end
  # end

end
