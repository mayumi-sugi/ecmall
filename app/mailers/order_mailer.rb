class OrderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.complete.subject
  #
  def complete(order)
    @order = order
    mail to: "to@example.org", subject: "ご注文が確定いたしました"
  end
end
