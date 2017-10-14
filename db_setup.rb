require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://store')

DB.create_table! :products do
  primary_key :id
  String :type, null: false
  String :name, null: false
  Float :price, null: false
  Integer :stock, null:false
  DateTime :expires_at
  DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, :index=>true
end

DB.create_table! :customers do
  primary_key :id
  String :name, null: false
  Boolean :is_loyal, default: false
end

DB.create_table! :coupons do
  primary_key :id
  foreign_key :customer_id, :customers
  String :product_type
  Float :value
  Boolean :is_used, default: false
end

DB.create_table! :sales do
  primary_key :id
  foreign_key :customer_id, :customers
  foreign_key :product_id, :products
  foreign_key :coupon_id, :coupons
  Float :value
  DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, :index=>true
end

products = DB[:products]

products.insert(type: 'coffee', name: 'espresso', price: 5, stock: 15, expires_at: '2018-10-01 00:00:00')
products.insert(type: 'coffee', name: 'pumpkin spice latte', price: 10, stock: 5, expires_at: '2018-10-01 00:00:00')
products.insert(type: 'coffee', name: 'americano', price: 5, stock: 15, expires_at: '2018-10-01 00:00:00')
products.insert(type: 'coffee', name: 'grande latte', price: 7, stock: 10, expires_at: '2018-10-01 00:00:00')
products.insert(type: 'coffee', name: 'decaf', price: 5, stock: 2, expires_at: '2017-10-01 00:00:00')
products.insert(type: 'coffee', name: 'latte', price: 5, stock: 15, expires_at: '2017-10-01 00:00:00')
products.insert(type: 'softdrink', name: 'pepsi', price: 7, stock: 15, expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', name: 'still water', price: 5, stock: 30, expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', name: 'cola', price: 7, stock: 15, expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', name: 'nestea', price: 6, stock: 13, expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', name: 'fanta', price: 7, stock: 15, expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', name: 'seven-up', price: 7, stock: 15, expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', name: 'tutti frutti', price: 3, stock: 5, expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', name: 'schweps', price: 7, stock: 15, expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', name: 'american cola', price: 3, stock: 5, expires_at: '2017-10-01 00:00:00')
products.insert(type: 'softdrink', name: 'aloe drink', price: 10, stock: 11, expires_at: '2017-10-01 00:00:00')
products.insert(type: 'softdrink', name: 'evian water', price: 7, stock: 20, expires_at: '2017-10-01 00:00:00')
products.insert(type: 'desserts', name: 'panna cotta', price: 15, stock: 15, expires_at: '2017-10-15 00:00:00')
products.insert(type: 'desserts', name: 'cheesecake', price: 25, stock: 10, expires_at: '2017-10-15 00:00:00')
products.insert(type: 'desserts', name: 'chocolate brownie', price: 13, stock: 30, expires_at: '2017-10-15 00:00:00')
products.insert(type: 'desserts', name: 'apple pie', price: 9, stock: 4, expires_at: '2017-10-15 00:00:00')
products.insert(type: 'desserts', name: 'pumpkin pie', price: 10, stock: 9, expires_at: '2017-10-15 00:00:00')
products.insert(type: 'desserts', name: 'strawberry waffle', price: 11, stock: 6, expires_at: '2017-10-10 00:00:00')
products.insert(type: 'desserts', name: 'rice pudding', price: 6, stock: 17, expires_at: '2017-10-10 00:00:00')
products.insert(type: 'desserts', name: 'tiramisu', price: 8, stock: 23, expires_at: '2017-10-10 00:00:00')
products.insert(type: 'cup', name: 'huge cup', price: 35, stock: 5)
products.insert(type: 'cup', name: 'big cup', price: 20, stock: 10)
products.insert(type: 'cup', name: 'medium cup', price: 15, stock: 15)
products.insert(type: 'coaster', name:'plain red coaster', price: 2, stock: 15)
products.insert(type: 'coaster', name:'plain yellow coaster', price: 2, stock: 15)
products.insert(type: 'coaster', name:'plain green coaster', price: 2, stock: 15)
products.insert(type: 'coaster', name:'stylish coaster', price: 3, stock: 10)
products.insert(type: 'coaster', name:'regular StarStruck coaster', price: 3, stock: 8)
products.insert(type: 'coaster', name:'rare edition StarStruck coaster', price: 5, stock: 2)
products.insert(type: 'keyring', name:'regular StarStruck keyring', price: 3, stock: 8)
products.insert(type: 'keyring', name:'plain keyring', price: 2, stock: 15)
products.insert(type: 'keyring', name:'rare edition StarStruck keyring', price: 5, stock: 3)

customers = DB[:customers]

customers.insert(name: 'Jorge')
customers.insert(name: 'Misu')
customers.insert(name: 'Bazil', is_loyal: true)

coupons = DB[:coupons]

coupons.insert(customer_id: 3, product_type: 'desserts', value: 10)

sales = DB[:sales]

sales.insert(customer_id: 3, product_id: 1, value: 5)
sales.insert(customer_id: 3, product_id: 4, value: 7)
