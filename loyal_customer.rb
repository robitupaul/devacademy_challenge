#require 'sqlite3'
#require 'sequel'

#DB = Sequel.connect('sqlite://store')

class LoyalCustomer < Customer

  def initialize(customer = nil)
    @name = customer.name unless customer.nil?
    @id = customer.id unless customer.nil?
    @is_loyal = true
  end

  def add
    customers = DB[:customers]
    @id = customers.insert(name: @name, is_loyal: true)
  end

  def delete
    coupons = DB[:coupons]
    coupons.where(customer_id: @id).delete
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
end
