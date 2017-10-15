# require 'sqlite3'
# require 'sequel'

# DB = Sequel.connect('sqlite://store')

class Customer

  attr_accessor :id, :name, :is_loyal

  def self.find(id)
    customers = DB[:customers]
    customer = customers[{ id: id }]
    raise Exception.new('could not find customer') if customer.nil?
    found_customer = Customer.new
    found_customer.id = customer[:id]
    found_customer.name = customer[:name]
    found_customer.is_loyal = customer[:is_loyal]
    found_customer
  end

  def add
    customers = DB[:customers]
    @id = customers.insert(name: @name)
  end

  def delete
    raise Exception.new('Cannot identify customer') if @id.nil?
    customers = DB[:customers]
    customers.where(id: @id).delete
  end

  def make_loyal
    raise Exception.new('Customer was not specified') if @id.nil?
    customers = DB[:customers]
    customers.where(id: @id).update(is_loyal: true)
    LoyalCustomer.new self
  end

  def show_cheapest
    show_top_products
  end

  def show_most_expensive
    show_top_products(false)
  end

  private

  #cheap -> { true => cheapest, false => most expensive}
  def show_top_products(cheap = true)
    types = ['coffee', 'softdrink', 'desserts', 'cup', 'coaster', 'keyring']
    coupons = Coupon.find_by_customer(@id)
    types.each do |type|
      products = Product.find_by_type(type)
      products = products.select { |p| p.stock > 0 && ( p.expires_at.nil? || p.expires_at > Time.now ) }
      coupon = coupons.select { |c| c.product_type == type && !c.is_used }.first
      products.sort! do |a,b|
        a_price = coupon ? a.price - a.price * coupon.value / 100 : a.price
        b_price = coupon ? b.price - b.price * coupon.value / 100 : b.price
        a_price < b_price ? -1 : (a_price == b_price ? 0 : 1)
      end
      products = cheap ? products.first(3) : products.last(3).reverse
      print "#{type}:\n"
      products.each do |product|
        discounted_price = product.price - product.price * coupon.value / 100 unless coupon.nil?
        print "\t#{product.name}, price: #{discounted_price || product.price} "
        print "with coupon: #{coupon.value}%" unless coupon.nil?
        print "\n"
      end
      print "\n"
    end
  end

  def self.all
    customers = DB[:customers].all
    customers.each do |customer|
      puts "id:#{customer[:id]} name:#{customer[:name]} loyal:#{customer[:is_loyal]}"
    end
    print "\n"
  end

  def self.all_regular
    customers = DB[:customers].where( is_loyal: false ).all
    customers.each do |customer|
      puts "id:#{customer[:id]} name:#{customer[:name]} loyal:#{customer[:is_loyal]}"
    end
    print "\n"
  end

end
