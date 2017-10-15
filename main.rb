require 'sqlite3'
require 'sequel'
require 'time'

DB = Sequel.connect('sqlite://store')

require './product.rb'
require './customer.rb'
require './coupon.rb'
require './sale.rb'
require './loyal_customer.rb'

puts "\n\n\t\tDevacademy RoR backend course - challenge"

def show_menu
  print "\n\n"
  puts "1. Add a new product"
  puts "2. Update stock of a product"
  puts "3. Add regular customer"
  puts "4. Upgrade regular customer to loyal"
  puts "5. Add loyal customer"
  puts "6. Add coupon to loyal customer"
  puts "7. Remove regular/loyal customer"
  puts "8. Make a sale"
  puts "9. Show sales history of last X days"
  puts "10. Show all product types with 0 stock or with expired products"
  puts "11. Show cheapest 3 products/type for customer"
  puts "12. Show most expensive 3 products/type of customer"
  puts "13. Quit"
  print "What would you like to do? (choose option 1-11) :"
end

def add_product
  puts "Adding product..."
  puts "Available product types: coffee, softdrink, desserts, cup, coaster, keyring"
  product = Product.new
  print "\ttype of product:"
  product.type = gets.chomp
  print "\tname:"
  product.name = gets.chomp
  print "\tprice:"
  product.price = gets.chomp.to_f
  print "\tstock:"
  product.stock = gets.chomp.to_i
  print "\texpiry date (YYYY-MM-DD HH:mm:ss):"
  product.expires_at = gets.chomp
  product.expires_at = nil if product.expires_at == ""
  product.add
  puts "Product was added successfully!"
  puts "Press ENTER to continue..."
  gets
end

def update_stock
  print "\n"
  puts "The product list is:"
  Product.all
  print "Insert product id:"
  id = gets.chomp.to_i
  print "New stock:"
  new_stock = gets.chomp.to_i
  product = Product.find(id)
  product.update_stock(new_stock)
  puts "Stock for name:#{product.name} type:#{product.type} was updated to #{new_stock}!"
  puts "Press ENTER to continue..."
  gets
end

def add_loyal_customer
  print "\n"
  puts "Let's add a loyal customer."
  loyal_customer = LoyalCustomer.new
  print "Insert loyal customer name:"
  loyal_customer.name = gets.chomp
  loyal_customer.add
  puts "Loyal customer was added successfully!"
  puts "Press ENTER to continue..."
  gets
end

def add_coupon_loyal_customer
  print "\n"
  puts "The list of loyal customers:"
  print "\n"
  LoyalCustomer.all
  puts "Adding a coupon to a loyal customer."
  print "Select the customer id from above:"
  loyal_customer_id = gets.chomp.to_i
  loyal_customer = LoyalCustomer.find(loyal_customer_id)
  puts "Available product types: coffee, softdrink, desserts, cup, coaster, keyring"
  print "Insert product type for the coupon:"
  product_type = gets.chomp
  print "\tcoupon value percentage:"
  coupon_value = gets.chomp.to_i
  loyal_customer.add_coupon(product_type,coupon_value)
  puts "Coupon type:#{product_type} value:#{coupon_value}% was added to loyal customer #{loyal_customer.name}"
  puts "Press ENTER to continue..."
  gets
end

def delete_customer
  print "\n"
  puts "The list of customers:"
  print "\n"
  Customer.all
  puts "WARNING: ALL sales and coupons of this customer will be forever erased!!!!"
  print "Select the customer id to be deleted:"
  customer_id = gets.chomp.to_i
  begin
    customer = LoyalCustomer.find(customer_id)
  rescue Exception => e
    customer = Customer.find(customer_id)
  end
  customer.delete
  puts "Loyal customer id:#{loyal_customer_id} name:#{loyal_customer.name} was successfully deleted!"
  puts "Press ENTER to continue..."
  gets
end

def make_sale
  print "\n"
  puts "The list of customers:"
  print "\n"
  Customer.all
  print "Insert customer id:"
  customer_id = gets.chomp.to_i
  print "\n"
  puts "The product list is:"
  Product.all
  print "Insert product id:"
  product_id = gets.chomp.to_i
  print "\n"
  sale = Sale.new(customer_id,product_id)
  print "Sale id: #{sale.id} by #{Customer.find(sale.customer_id).name} product:#{Product.find(sale.product_id).name} "
  print "value:#{sale.value} "
  print "using coupon id: #{sale.coupon_id} of #{Coupon.find(sale.coupon_id).value}%" unless sale.coupon_id.nil?
  print "\n"
  puts "Press ENTER to continue..."
  gets
end

def show_history_X
  print "\n"
  print "Insert number of days:"
  days = gets.chomp.to_i
  print "\n"
  Sale.show_history(days)
  puts "Press ENTER to continue..."
  gets
end

def show_cheapest
  print "\n"
  puts "The list of customers:"
  print "\n"
  Customer.all
  print "Select the customer id from above:"
  customer_id = gets.chomp.to_i
  Customer.find(customer_id).show_cheapest
  puts "Press ENTER to continue..."
  gets
end

def show_most_expensive
  print "\n"
  puts "The list of customers:"
  print "\n"
  Customer.all
  print "Select the customer id from above:"
  customer_id = gets.chomp.to_i
  Customer.find(customer_id).show_most_expensive
  puts "Press ENTER to continue..."
  gets
end

def add_regular_customer
  print "\n"
  puts "Let's add a customer."
  customer = Customer.new
  print "Insert customer name:"
  customer.name = gets.chomp
  customer.add
  puts "Customer was added successfully!"
  puts "Press ENTER to continue..."
  gets
end

def upgrade_customer
  print "\n"
  puts "The list of regular customers:"
  print "\n"
  Customer.all_regular
  print "Select the customer id from above:"
  customer_id = gets.chomp.to_i
  customer = Customer.find(customer_id)
  customer.make_loyal
  puts "Regular customer id:#{customer.id} name:#{customer.name} was upgraded to loyal status! Congrats!"
  puts "Press ENTER to continue..."
  gets
end

while true do
  show_menu
  option = gets
  case option.to_i
  when 1
    add_product
  when 2
    update_stock
  when 3
    add_regular_customer
  when 4
    upgrade_customer
  when 5
    add_loyal_customer
  when 6
    add_coupon_loyal_customer
  when 7
    delete_customer
  when 8
    make_sale
  when 9
    show_history_X
  when 10
    Product.show_unavailable
  when 11
    show_cheapest
  when 12
    show_most_expensive
  when 13
    puts "bye!"
    exit
  else
    puts "Unrecognized option."

  end
end

