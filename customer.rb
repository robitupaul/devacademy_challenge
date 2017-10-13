require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://store')

class Customer
  attr_accessor :id, :name

  def add
    customers = DB[:customers]
    customers.insert(name: @name)
  end
end
