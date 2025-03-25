class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def index
    @orders = current_customer.orders.latest
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def new
    @customer = current_customer
    @order = Order.new
    @subtotal = @customer.cart_items.inject(0) { |sum, cart_item| sum + cart_item.line_total }
    @billing_amount = @subtotal + POSTAGE
  end

  def create
    ActiveRecord::Base.transaction do
      @order = current_customer.orders.new(order_params)

      if @order.save
        create_order_details(@order)
        OrderMailer.complete(@order).deliver_now
        current_customer.cart_items.destroy_all
        redirect_to success_orders_path(@order), notice: "購入が完了しました"
      else
        @customer = current_customer
        @subtotal = @customer.cart_items.inject(0) { |sum, cart_item| sum + cart_item.line_total }
        @billing_amount = @subtotal + POSTAGE
        render :new, status: :unprocessable_entity
      end
    end
  # 例外処理
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
      product = cart_item.product
      product.stock -= cart_item.quantity
      product.save!
    end
  end
end
