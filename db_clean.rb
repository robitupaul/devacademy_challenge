require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://store')

DB[:sales].delete
DB[:coupons].delete
DB[:customers].delete
DB[:products].delete
