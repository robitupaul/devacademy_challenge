# require 'sqlite3'
# require 'sequel'

# DB = Sequel.connect('sqlite://store')

class Product

  attr_accessor :id, :name, :type, :price, :stock, :expires_at

  def self.find(id)
    products = DB[:products]
    product = products[{ id: id }]
    raise Exception.new('could not find product') if product.nil?
    new_product = Product.new
    new_product.id = product[:id]
    new_product.name = product[:name]
    new_product.type = product[:type]
    new_product.price = product[:price]
    new_product.stock = product[:stock]
    new_product.expires_at = product[:expires_at]
    new_product
  end

  def add
    products = DB[:products]
    @id = products.insert(type: @type, price: @price, stock: @stock, expires_at: @expires_at)
  end

  def update_stock(stock)
    return false if @id.nil? or stock.nil?
    products = DB[:products]
    products.where(id: @id).update(stock: stock)
    @stock = stock
  end

  def delete
    return false if @id.nil?
    products = DB[:products]
    products.where(id: @id).delete
  end

  #to be deleted when finders are in place
  def self.delete(id)
    products = DB[:products]
    products.where(id: id).delete
  end

end
