class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :payments
  scope :with_parent, -> { includes(:product, :user) }
end
