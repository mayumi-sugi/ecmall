class Customer::ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).order(created_at: :asc)
    @rank_products = Product
      .joins(:order_details) # Productモデルに対してorder_detailsテーブルを結合
      .select("products.*, sum(order_details.quantity) as total_quantity") # 購入数を集計
      .group("products.id") # 商品ごとにグループ化
      .order("total_quantity desc") # 購入数が多い順に並べる
      .limit(3) # 上位3つの商品を取得
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
end
