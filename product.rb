# require 'sqlite3'
# require 'sequel'

# DB = Sequel.connect('sqlite://store')

class Product

  attr_accessor :id, :name, :type, :price, :stock, :expires_at

  def self.find(id)
    products = DB[:products]
    product = products[{ id: id }]
    raise Exception.new('could not find product') if product.nil?
    found_product = Product.new
    found_product.id = product[:id]
    found_product.name = product[:name]
    found_product.type = product[:type]
    found_product.price = product[:price]
    found_product.stock = product[:stock]
    found_product.expires_at = product[:expires_at]
    found_product
  end

  def self.find_by_type(type)
    products = DB[:products].where( type: type ).all
    raise Exception.new("There are no products of type #{type}") if products.nil?
    found_products = []
    products.each do |product|
      found_product = Product.new
      found_product.id = product[:id]
      found_product.name = product[:name]
      found_product.type = product[:type]
      found_product.price = product[:price]
      found_product.stock = product[:stock]
      found_product.expires_at = product[:expires_at]
      found_products << found_product
    end
    found_products
  end

  def add
    products = DB[:products]
    @id = products.insert(type: @type, price: @price, stock: @stock, expires_at: @expires_at)
  end

  def delete
    return false if @id.nil?
    products = DB[:products]
    products.where(id: @id).delete
  end

  def update_stock(stock)
    return false if @id.nil? or stock.nil?
    products = DB[:products]
    products.where(id: @id).update(stock: stock)
    @stock = stock
  end

  #to be deleted when finders are in place
  def self.delete(id)
    products = DB[:products]
    products.where(id: id).delete
  end

  #Show all products with 0 stock or are expired
  def self.show_unavailable
    products = DB[:products]
    unavailable_products = products.where{ Sequel.|({ stock: 0}, Sequel.&((expires_at !~ nil), (expires_at < Time.now) )) }.all
    unavailable_products.each do |product|
      print "Product #{product[:name]} / type: #{product[:type]} "
      print "has 0 stock " if product[:stock].zero?
      print "is expired" if !product[:expires_at].nil? and product[:expires_at] < Time.now
      print "\n"
    end
  end

end
