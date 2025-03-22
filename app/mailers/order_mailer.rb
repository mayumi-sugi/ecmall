class OrderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.complete.subject
  #
  def complete(order)
    @order = order
    @order_details = @order.order_details.includes(:product)

    mail to: "to@example.org", subject: "決済が完了しました。"
  end
end
