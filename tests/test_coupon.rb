require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://../store')

require '../coupon.rb'
require '../customer.rb'

puts "Testing coupon find"
found_coupon = Coupon.find(3)
puts "Customer with the id: #{found_coupon.customer_id} and name: #{Customer.find(found_coupon.customer_id).name} has the coupon id: #{found_coupon.id} for #{found_coupon.product_type} with #{found_coupon.value}\% discount." unless found_coupon.nil?

