class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :shippings, dependent: :destroy
  has_one :shipping_state, dependent: :destroy

  scope :with_parent, -> { includes(:customer) }
  scope :sorted, -> { order('created_at DESC') }
  scope :action_required, -> { joins(:shippings).where(shippings: { status: Shipping.statuses[:shipping_request] }) }
end
