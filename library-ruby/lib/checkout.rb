require('pg')
require('pry')
require('date')

class Checkout
  attr_accessor :id, :patron_id, :book_id, :due_date, :checkout_date, :out

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @patron_id = attributes.fetch(:patron_id)
    @book_id = attributes.fetch(:book_id)
    @due_date = attributes.fetch(:due_date)
    @checkout_date = attributes.fetch(:checkout_date)
    @out = attributes.fetch(:out)
  end

  def ==(another_checkout)
    self.book_id().==(another_checkout.book_id()).&(self.id().==(another_checkout.id()))
  end

  def checkin_book
    DB.exec("UPDATE checkouts SET out = 'f' WHERE id = '#{self.id}'")
    self.out = 'f'
  end

  def self.all
    returned_checkouts = DB.exec("SELECT * FROM checkouts;")
    checkouts = []
    returned_checkouts.each do |each|
      patron_id = each.fetch("patron_id").to_i
      book_id = each.fetch("book_id").to_i
      due_date = each.fetch("due_date")
      checkout_date = each.fetch("checkout_date")
      out = each.fetch("out")
      id = each.fetch("id").to_i()
      checkouts.push(Checkout.new({:book_id => book_id, :patron_id => patron_id, :due_date => due_date, :checkout_date => checkout_date, :out => out, :id => id}))
    end
    return checkouts
  end

  def save
    todaysdate = Date.today
    @checkout_date = todaysdate.strftime('%Y-%m-%d')
    futuredate = Date.today + 14
    @due_date = futuredate.strftime('%Y-%m-%d')
    @out = self.out = 't'
    result = DB.exec("INSERT INTO checkouts (patron_id, book_id, due_date, checkout_date, out) VALUES ('#{@patron_id}', '#{@book_id}', '#{@due_date}', '#{@checkout_date}', '#{@out}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find_by_patron(pid)
    found_history = []
    all_checkouts = Checkout.all
    all_checkouts.each do |each|
      if each.patron_id == pid
        found_history.push(each)
      end
    end
    return found_history
  end

end
