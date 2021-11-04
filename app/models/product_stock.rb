class ProductStock < ApplicationRecord
  belongs_to :product

  def current_stock
    ProductStock.where(product_id: product_id).sum(:stock)
  end
end
