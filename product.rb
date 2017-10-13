require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://store')

class Product

  attr_accessor :id, :type, :price, :stock_number, :expires_at

  # def initialize(id)
  #   products = DB[:products]
  #   product = products[{ id: id }]
  #   raise Exception.new('unknown product') if product.nil?
  #   @id = product[:id]
  #   @type = product[:type]
  #   @price = product[:price]
  #   @stock_number = product[:stock_number]
  #   @expires_at = product[:expires_at]
  # end

  def add
    products = DB[:products]
    @id = products.insert(type: @type, price: @price, stock_number: @stock_number, expires_at: @expires_at)
  end

  def delete
    return false if @id.nil?
    products = DB[:products]
    products.where(id: @id).delete
  end

  def self.delete(id)
    products = DB[:products]
    products.where(id: id).delete
  end

end
