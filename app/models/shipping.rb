class Shipping < ApplicationRecord
  belongs_to :order

  enum status: {
    shipping_request: 1,
    shipping_in_ready: 2,
    cancellation_request: 3,
    cancellation_complete: 4,
    shipping_complete: 5
  }
end
