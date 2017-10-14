require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://store')

require './customer.rb'
require './coupon.rb'
require './loyal_customer.rb'


#### Testing add/remove (loyal) customer and coupons

puts 'Customers and coupons already present'
puts "CUSTOMERS\n------------------"
puts DB[:customers].all
print "\n"
puts "COUPONS\n------------------"
puts DB[:coupons].all
print "\n"

customer = Customer.new
customer.name = 'Vasile'
customer.add
puts "#{customer.name} was added as a customer"
puts "CUSTOMERS\n------------------"
puts DB[:customers].all
print "\n"

loyal_customer = customer.make_loyal
loyal_customer.add_coupon('coffee', 10)
puts "#{loyal_customer.name} was added as a loyal customer and coupon"
puts "CUSTOMERS\n------------------"
puts DB[:customers].all
print "\n"
puts "COUPONS\n------------------"
puts DB[:coupons].all
print "\n"

other_loyal_customer = LoyalCustomer.new
other_loyal_customer.name = 'Andreea'
other_loyal_customer.add
puts "#{other_loyal_customer.name} was added directly as a loyal customer"
puts "CUSTOMERS\n------------------"
puts DB[:customers].all
print "\n"

other_loyal_customer.add_coupon('desserts', 20)
puts "Coupon was added to #{other_loyal_customer.name}"
puts "COUPONS\n------------------"
puts DB[:coupons].all

puts "\nDeleting #{loyal_customer.name} and its coupons"
loyal_customer.delete
puts "CUSTOMERS\n------------------"
puts DB[:customers].all
print "\n"
puts "COUPONS\n------------------"
puts DB[:coupons].all
print "\n"
