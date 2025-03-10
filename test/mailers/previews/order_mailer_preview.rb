# Preview all emails at http://localhost:3003/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3003/rails/mailers/order_mailer/complete
  def complete
    order = Order.last || Order.new(id: 1, customer: Customer.new(email: "sato.mamoru@gmail.com"), order_items: [])
    OrderMailer.complete(order)
  end
end
