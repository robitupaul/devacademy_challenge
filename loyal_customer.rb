#require 'sqlite3'
#require 'sequel'

#DB = Sequel.connect('sqlite://store')

class LoyalCustomer < Customer

  def initialize(customer = nil)
    @name = customer.name unless customer.nil?
    @id = customer.id unless customer.nil?
    @is_loyal = true
  end

  def self.find(id)
    customers = DB[:customers]
    customer = customers[{ id: id, is_loyal: true }]
    raise Exception.new("could not find loyal customer") if customer.nil?
    found_customer = LoyalCustomer.new
    found_customer.id = customer[:id]
    found_customer.name = customer[:name]
    found_customer.is_loyal = customer[:is_loyal]
    found_customer
  end

  def add
    customers = DB[:customers]
    @id = customers.insert(name: @name, is_loyal: true)
  end

  def delete
    DB[:sales].where(customer_id: @id).delete
    DB[:coupons].where(customer_id: @id).delete
    super
  end

  def add_coupon(product_type, value)
    raise Exception.new('Cannot add coupon for unsaved customer') if @id.nil?
    types = ['coffee', 'softdrink', 'desserts', 'cup', 'coaster', 'keyring']
    raise Exception.new("Type #{product_type} does not exist. Try one of #{types}") unless types.include? product_type
    coupon = Coupon.new
    coupon.customer_id = @id
    coupon.product_type = product_type
    coupon.value = value
    coupon.add
  end

  def self.all
    customers = DB[:customers].where( is_loyal: 1 ).all
    customers.each do |customer|
      puts "id:#{customer[:id]} name:#{customer[:name]}"
    end
    print "\n"
  end
end
