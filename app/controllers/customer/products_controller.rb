class Customer::ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).order(created_at: :asc)
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
end
