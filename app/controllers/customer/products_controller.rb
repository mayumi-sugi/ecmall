class Customer::ProductsController < ApplicationController
  def index
    @products, @sort = get_products(params)
    @rank_products = Product
      .joins(:order_details)
      .select("products.*, sum(order_details.quantity) as total_quantity")
      .group("products.id")
      .order("total_quantity desc")
      .limit(3)
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def get_products(params)
    return Product.all, "default" unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high]

    return Product.latest, "latest" if params[:latest]

    return Product.price_high_to_low, "price_high_to_low" if params[:price_high_to_low]

    return Product.price_low_to_high, "price_low_to_high" if params[:price_low_to_high]
  end
end
