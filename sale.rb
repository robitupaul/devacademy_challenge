class Sale

  attr_accessor :id, :customer_id, :product_id, :coupon_id, :value

  def initialize(customer_id, product_id)
    customer = Customer.find(customer_id)
    product = Product.find(product_id)

    raise Exception.new('Product is out of stock') if product.stock.zero?
    raise Exception.new('Product is expired') unless product.expires_at.nil? or product.expires_at > Time.now

    price = product.price
    coupon_id = nil
    if customer.is_loyal
      begin
        coupons = Coupon.find_by_customer(customer_id)
        coupons.each do |coupon|
          if product.type == coupon.product_type and !coupon.is_used
            price = product.price - product.price * coupon.value / 100
            coupon.use
            coupon_id = coupon.id
            break
          end
        end
      rescue Exception => e

      end
    end

    sales = DB[:sales]
    @id = sales.insert(customer_id: customer_id, product_id: product_id, coupon_id: coupon_id, value: price)
    @customer_id = customer_id
    @product_id = product_id
    @coupon_id = coupon_id
    @value = price
    product.update_stock(product.stock - 1)
  end

  def self.show_history(days)
    sales = DB[:sales]
    last_days_sales = sales.where{ created_at > Time.now - days*60*60*24 }.all
    last_days_sales.each do |sale|
      print "Sale id: #{sale[:id]} by #{Customer.find(sale[:customer_id]).name} product:#{Product.find(sale[:product_id]).name} "
      print "on #{sale[:created_at]} value:#{sale[:value]} "
      print "using coupon id: #{sale[:coupon_id]} of #{Coupon.find(sale[:coupon_id]).value}%" unless sale[:coupon_id].nil?
      print "\n"
    end
  end

end
