class ShippingAddress < ApplicationRecord
  belongs_to :customer
  belongs_to :prefecture

  delegate :prefecture_name, to: :prefecture

  def full_address
    "#{prefecture_name}#{address}"
  end
end
