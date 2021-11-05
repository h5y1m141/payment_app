class ShippingAddress < ApplicationRecord
  belongs_to :customer
  belongs_to :prefecture
end
