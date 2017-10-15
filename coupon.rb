# require 'sqlite3'
# require 'sequel'

# DB = Sequel.connect('sqlite://store')

class Coupon

  attr_accessor :id, :customer_id, :product_type, :value, :is_used

  def self.find(id)
    coupons = DB[:coupons]
    coupon = coupons[{ id: id }]
    raise Exception.new('Coupon not found') if coupon.nil?
    found_coupon = Coupon.new
    found_coupon.id = coupon[:id]
    found_coupon.customer_id = coupon[:customer_id]
    found_coupon.product_type = coupon[:product_type]
    found_coupon.value = coupon[:value]
    found_coupon.is_used = coupon[:is_used]
    found_coupon
  end

  def self.find_by_customer(customer_id)
    coupons = DB[:coupons].where( customer_id: customer_id ).all
    raise Exception.new('Customer doesn\'t have any coupons') if coupons.nil?
    found_coupons = []
    coupons.each do |coupon|
      found_coupon = Coupon.new
      found_coupon.id = coupon[:id]
      found_coupon.customer_id = coupon[:customer_id]
      found_coupon.product_type = coupon[:product_type]
      found_coupon.value = coupon[:value]
      found_coupon.is_used = coupon[:is_used]
      found_coupons << found_coupon
    end
    found_coupons
  end

  def add
    coupons = DB[:coupons]
    coupons.insert(customer_id: @customer_id, product_type: @product_type, value: @value)
  end

  def use
    coupons = DB[:coupons]
    coupons.where(id: @id).update(is_used: true)
    @is_used = true
  end

end
