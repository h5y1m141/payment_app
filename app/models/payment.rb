class Payment < ApplicationRecord
  STRIPE_COMMISION_RATE = 0.036

  belongs_to :order
  belongs_to :payment_method

  enum payment_type: { transaction_start: 0, transaction_success: 1, transaction_fail: 2 }

  class << self
    def transaction_start!(order:, payment_method:)
      amount = order.amount + STRIPE_COMMISION_RATE
      create!(
        order_id: order.id,
        payment_method_id: payment_method.id,
        amount: amount,
        payment_type: payment_types[:transaction_start],
        code: '該当なし'
      )
    end
  end
end
