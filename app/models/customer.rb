class Customer < ApplicationRecord
  has_many :customer_payment_methods
end
