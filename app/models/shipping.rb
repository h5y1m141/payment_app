class Shipping < ApplicationRecord
  belongs_to :order

  enum status: { shipping_request: 1, shipping_in_ready: 2, shipping_complete: 3 }

  scope :target_order_ids, lambda { |status|
    group(:order_id)
      .maximum(:status)
      .select { |key, value| key if value == status }
      .keys
  }
  scope :request_list, lambda {
    status = Shipping.statuses[:shipping_request]
    where(order_id: target_order_ids(status), status: status)
  }

  scope :in_ready_list, lambda {
    status = Shipping.statuses[:shipping_in_ready]
    where(order_id: target_order_ids(status), status: status)
  }

  scope :complete_list, lambda {
    status = Shipping.statuses[:shipping_complete]
    where(order_id: target_order_ids(status), status: status)
  }
end
