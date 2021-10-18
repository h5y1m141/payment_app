class Order < ApplicationRecord
  belongs_to :customer

  has_many :payments
  scope :with_parent, -> { includes(:customer) }
end
