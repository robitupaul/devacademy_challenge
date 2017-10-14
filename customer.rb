# require 'sqlite3'
# require 'sequel'

# DB = Sequel.connect('sqlite://store')

class Customer

  attr_accessor :id, :name

  def add
    customers = DB[:customers]
    @id = customers.insert(name: @name)
  end

  def delete
    raise Exception.new('Cannot identify customer') if @id.nil?
    customers = DB[:customers]
    customers.where(id: @id).delete
  end

  def make_loyal
    raise Exception.new('Customer was not specified') if @id.nil?
    customers = DB[:customers]
    customers.where(id: @id).update(is_loyal: true)
    LoyalCustomer.new self
  end

end
