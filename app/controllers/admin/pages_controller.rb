class Admin::PagesController < ApplicationController
  before_action :authenticate_admin!

  def home
    @orders, @selected = get_orders(params) # @selectedは絞り込み検索を行うセレクトボックスの値を制御するためのもの
    today_orders = Order.created_today
    @today_total_orders = total_orders(today_orders)
    @today_total_sales = total_sales(today_orders)
  end

  private

  def get_orders(params)
    if !params[:status].present? || !Order.statuses.keys.to_a.include?(params[:status])
      # すべての注文を取得
      return [ Order.eager_load(:customer).latest, "all" ]
    end
    # 指定されたステータスの注文のみ取得
    get_by_enum_value(params[:status])
  end

  def get_by_enum_value(status)
    case status
    when "waiting_payment"
      [ Order.waiting_payment.eager_load(:customer).latest, "waiting_payment" ]
    when "confirm_payment"
      [ Order.confirm_payment.eager_load(:customer).latest, "confirm_payment" ]
    when "shipped"
      [ Order.shipped.eager_load(:customer).latest, "shipped" ]
    when "out_of_delivery"
      [ Order.out_of_delivery.eager_load(:customer).latest, "out_of_delivery" ]
    when "delivered"
      [ Order.delivered.eager_load(:customer).latest, "delivered" ]
    end
  end
  # 1日の注文数を返すメソッド
  def total_orders(orders)
    orders.count
  end
  # 1日の売り上げを返すメソッド
  def total_sales(orders)
    orders.sum(:billing_amount)
  end
end
