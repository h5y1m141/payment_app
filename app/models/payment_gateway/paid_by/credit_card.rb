module PaymentGateway
  module PaidBy
    class CreditCard
      class << self
        # NOTE: 仮売上状態にした場合は後述のcaptureを実行する必要ある。
        # 即時決済の場合は最初からstartのメソッドで対応する
        def authorization(order:, amount:)
          Stripe::PaymentIntent.create({
                                         amount: amount,
                                         currency: 'jpy',
                                         confirm: false,
                                         customer: order.user.customer_id,
                                         payment_method: order.user.current_credit_card_id
                                       })
        end

        def capture(order:, amount:)
          payment_intent_id = order.payments.transaction_success.last
          return if payment_intent_id.blank?

          params = {
            amount: amount,
            payment_intent_id: payment_intent_id
          }

          Stripe::PaymentIntent.capture(params)
        end

        def start(order:, amount:)
          params = {
            amount: amount,
            currency: 'jpy',
            confirm: true,
            customer: order.user.customer_id,
            payment_method: order.user.current_credit_card_id
          }
          Stripe::PaymentIntent.create(params)
        end

        def cancel(order:, amount:)
          payment_intent_id = order.payments.transaction_success.last
          return if payment_intent_id.blank?

          params = {
            amount: amount,
            payment_intent_id: payment_intent_id
          }

          Stripe::PaymentIntent.cancel(params)
        end
      end
    end
  end
end
