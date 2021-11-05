class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_items, dependent: :destroy
  has_many :shippings, dependent: :destroy
  scope :with_parent, -> { includes(:customer) }
end
