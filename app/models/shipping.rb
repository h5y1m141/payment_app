class Shipping < ApplicationRecord
  belongs_to :order

  enum status: { shipping_request: 1, shipping_in_ready: 2, shipping_complete: 3 }
  scope :request_list, lambda {
    order_ids = group(:order_id)
          .maximum(:status)
          .select { |key, value| key if value == Shipping.statuses[:shipping_request] }
          .keys
    where(order_id: order_ids)
  }
end
