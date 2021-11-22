class ShippingAddress < ApplicationRecord
  belongs_to :customer
  belongs_to :prefecture

  delegate :prefecture_name, to: :prefecture
end
