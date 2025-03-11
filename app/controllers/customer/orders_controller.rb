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
    ActiveRecord::Base.transaction do
      @order = current_customer.orders.new(order_params)
      # @order.customer_id = current_customer.id

      if @order.save
        create_order_details(@order)
        OrderMailer.complete(@order).deliver_now
        current_customer.cart_items.destroy_all
        redirect_to success_orders_path(@order), notice: "購入が完了しました"
      else
        # binding.irb
        render :new
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = "購入に失敗しました"
    render :new
  end

  def success; end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :prefecture, :address1, :address2, :postage, :billing_amount, :status)
  end

  def create_order_details(order)
    current_customer.cart_items.each do |cart_item|
      order.order_details.create!(
        product_id: cart_item.product_id,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end
  end
end
