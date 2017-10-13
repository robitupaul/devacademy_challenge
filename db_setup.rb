require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://store')

DB.create_table! :products do
  primary_key :id
  String :type, null: false
  Float :price, null: false
  Integer :stock_number, null:false
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

products.insert(type: 'coffee', price: 5, stock_number: '1111111', expires_at: '2018-10-01 00:00:00')
products.insert(type: 'coffee', price: 10, stock_number: '1111112', expires_at: '2018-10-01 00:00:00')
products.insert(type: 'coffee', price: 5, stock_number: '1111113', expires_at: '2018-10-01 00:00:00')
products.insert(type: 'coffee', price: 7, stock_number: '1111114', expires_at: '2018-10-01 00:00:00')
products.insert(type: 'coffee', price: 5, stock_number: '1111115', expires_at: '2017-10-01 00:00:00')
products.insert(type: 'coffee', price: 5, stock_number: '1111116', expires_at: '2017-10-01 00:00:00')
products.insert(type: 'softdrink', price: 7, stock_number: '2222221', expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', price: 5, stock_number: '2222222', expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', price: 7, stock_number: '2222223', expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', price: 6, stock_number: '2222224', expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', price: 7, stock_number: '2222225', expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', price: 7, stock_number: '2222226', expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', price: 3, stock_number: '2222227', expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', price: 7, stock_number: '2222228', expires_at: '2017-12-01 00:00:00')
products.insert(type: 'softdrink', price: 3, stock_number: '2222229', expires_at: '2017-10-01 00:00:00')
products.insert(type: 'softdrink', price: 10, stock_number: '2222210', expires_at: '2017-10-01 00:00:00')
products.insert(type: 'softdrink', price: 7, stock_number: '2222211', expires_at: '2017-10-01 00:00:00')
products.insert(type: 'deserts', price: 15, stock_number: '3333331', expires_at: '2017-10-15 00:00:00')
products.insert(type: 'deserts', price: 25, stock_number: '3333332', expires_at: '2017-10-15 00:00:00')
products.insert(type: 'deserts', price: 13, stock_number: '3333333', expires_at: '2017-10-15 00:00:00')
products.insert(type: 'deserts', price: 9, stock_number: '3333334', expires_at: '2017-10-15 00:00:00')
products.insert(type: 'deserts', price: 10, stock_number: '3333335', expires_at: '2017-10-15 00:00:00')
products.insert(type: 'deserts', price: 11, stock_number: '3333336', expires_at: '2017-10-10 00:00:00')
products.insert(type: 'deserts', price: 6, stock_number: '3333337', expires_at: '2017-10-10 00:00:00')
products.insert(type: 'deserts', price: 8, stock_number: '3333338', expires_at: '2017-10-10 00:00:00')
products.insert(type: 'cup', price: 35, stock_number: '4444441')
products.insert(type: 'cup', price: 20, stock_number: '4444442')
products.insert(type: 'cup', price: 15, stock_number: '4444443')
products.insert(type: 'coaster', price: 2, stock_number: '5555551')
products.insert(type: 'coaster', price: 2, stock_number: '5555552')
products.insert(type: 'coaster', price: 2, stock_number: '5555553')
products.insert(type: 'coaster', price: 3, stock_number: '5555554')
products.insert(type: 'coaster', price: 3, stock_number: '5555555')
products.insert(type: 'coaster', price: 5, stock_number: '5555556')
products.insert(type: 'keyring', price: 3, stock_number: '6666661')
products.insert(type: 'keyring', price: 2, stock_number: '6666662')
products.insert(type: 'keyring', price: 5, stock_number: '6666663')

customers = DB[:customers]

customers.insert(name: 'Jorge')
customers.insert(name: 'Misu')
customers.insert(name: 'Bazil', is_loyal: true)

coupons = DB[:coupons]

coupons.insert(customer_id: 3, product_type: 'deserts', value: 10)

sales = DB[:sales]

sales.insert(customer_id: 3, product_id: 1, value: 5)
sales.insert(customer_id: 3, product_id: 4, value: 7)