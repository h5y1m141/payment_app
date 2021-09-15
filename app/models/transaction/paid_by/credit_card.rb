module Transaction
  module PaidBy
    class CreditCard < Base
      def initialize; end

      def start
        ActiveRecord::Base.transaction do
          payment = Payment.transaction_start!(
            order: order,
            payment_method: payment_method
          )
          begin
            result = PaymentGateway::PaidBy::CreditCard.start(order: order, amount: amount)
            Payment.create!(
              order_id: order.id,
              payment_method_id: payment_method.id,
              amount: payment.amount,
              payment_type: Payment.payment_types[:transaction_success],
              code: result.id,
            )
          rescue Stripe::CardError => e
            Payment.create!(
              order_id: order.id,
              payment_method_id: payment_method.id,
              amount: payment.amount,
              payment_type: Payment.payment_types[:transaction_fail],
              code: e.error.code,
            )
          end
        end
      end

      private

      def payment_method
        PaymentMethod.find_by(name: 'クレジットカード')
      end
    end
  end
end