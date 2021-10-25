class Product < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_one :product_stock, dependent: :destroy

  delegate :currnt_stock, to: :product_stock
end
