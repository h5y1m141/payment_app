class Shipping < ApplicationRecord
  belongs_to :order

  enum status: { shipping_request: 1, shipping_in_ready: 2, shipping_complete: 3 }
end
