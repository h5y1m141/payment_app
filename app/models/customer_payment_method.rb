class CustomerPaymentMethod < ApplicationRecord
  belongs_to :customer

  class << self
    def create_stripe_payment_intent(customer, params)
      if CustomerPaymentMethod.where(payment_method_id: params[:payment_method][:id]).exists?
        Stripe::PaymentIntent.create({
          customer: customer.stripe_customer_id,
          amount: params[:total_price],
          currency: 'jpy',
          payment_method: params[:payment_method][:id],
          confirm: true,
          setup_future_usage: "on_session"
        })
      else
        create!(
          customer_id: customer.id,
          payment_method_id: params[:payment_method][:id],
          brand: params[:payment_method][:card][:brand],
          exp_month: params[:payment_method][:card][:exp_month],
          exp_year: params[:payment_method][:card][:exp_year]
        )
        Stripe::PaymentIntent.create({
          customer: customer.stripe_customer_id,
          amount: params[:total_price],
          currency: 'jpy',
          payment_method: params[:payment_method][:id],
          confirm: true,
          setup_future_usage: "on_session"
        })
      end
    end
  end
end
