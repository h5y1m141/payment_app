class Order < ApplicationRecord
  belongs_to :customer

  has_many :payments, dependent: :destroy
  scope :with_parent, -> { includes(:customer) }
end
