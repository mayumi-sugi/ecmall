class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def index
    @orders = current_customer.orders.latest
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def new
    # customer_id : customer 情報の取得（id)
    @customer = current_customer
    @order = Order.new
    #
    # billing amount: カート情報の取得(価格、個数)
    #                  合計金額を計算
    # postage : 送料
    @subtotal = @customer.cart_items.inject(0) { |sum, cart_item| sum + cart_item.line_total }
    @billing_amount = @subtotal + POSTAGE
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

    if @order.save
      OrderMailer.complete(@order).deliver_now
      current_customer.cart_items.destroy_all
      redirect_to success_orders_path(@order), notice: "購入が完了しました"
    else
      # binding.irb
      render :new
    end
  end
  def success; end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :prefecture, :address1, :address2, :postage, :billing_amount, :status)
  end
end
