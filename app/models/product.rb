class Product < ApplicationRecord
  has_many :orders
  has_one :product_stock

  delegate :currnt_stock, to: :product_stock
end
