class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: %i[show update]

  def index
    @customers = Customer.preload(:orders).latest
  end

  def show; end

  def update
    @customer.update(customer_params)
    redirect_to request.referer, notice: "顧客情報を更新しました"
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:status)
  end
end
