require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://store')

require './customer.rb'

class LoyalCustomer < Customer

  def add
    customers = DB[:customers]
    customers.insert(name: @name, is_loyal: true)
  end

end
