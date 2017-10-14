# require 'sqlite3'
# require 'sequel'

# DB = Sequel.connect('sqlite://store')

class Coupon

  attr_accessor :customer_id, :product_type, :value

  def add
    coupons = DB[:coupons]
    coupons.insert(customer_id: @customer_id, product_type: @product_type, value: @value)
  end

end
