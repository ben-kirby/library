require 'spec_helper'

describe(Checkout) do
  describe('.all') do

    it("should return all instances in an array") do
      checkout1 = Checkout.new({:book_id => 1, :patron_id => 1, :due_date => "2000-12-10", :checkout_date => "2000-12-11", :out => nil, :id => nil})
      checkout1.save
      checkout2 = Checkout.new({:book_id => 2, :patron_id => 2, :due_date => "2000-12-10", :checkout_date => "2000-12-11", :out => nil, :id => nil})
      checkout2.save
      expect(Checkout.all).to(eq([checkout1, checkout2]))
    end
  end

  describe('.all') do
    it("should return all instances in an array") do
      checkout1 = Checkout.new({:book_id => 1, :patron_id => 1, :due_date => "2000-12-10", :checkout_date => "2000-12-11", :out => nil, :id => nil})
      checkout1.save
      checkout1.checkin_book
      expect(Checkout.all).to(eq("text"))
    end
  end
end
