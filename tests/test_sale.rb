require 'sqlite3'
require 'sequel'
require 'time'

DB = Sequel.connect('sqlite://../store')

require '../product.rb'
require '../customer.rb'
require '../coupon.rb'
require '../sale.rb'
require '../loyal_customer.rb'

loyal_customer = LoyalCustomer.new
loyal_customer.name = 'Virginia'
loyal_customer.add

loyal_customer.add_coupon('desserts', 15)

sale = Sale.new(loyal_customer.id, 19)

Sale.show_history(3)
