require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://../store')

require '../product.rb'

product = Product.find(1)

puts "Testing the finder"
puts "THe product no #{product.id} with name=#{product.name} having stock=#{product.stock}"

puts "Updating the stock to 20..."
product.update_stock(15)
puts "Now the stock is #{product.stock}"

puts "PRODUCTS\n------------------"
puts DB[:products][id: 1]
print "\n"
