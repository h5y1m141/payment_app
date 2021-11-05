class Customer < ApplicationRecord
  has_many :customer_payment_methods, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  class << self
    def find_or_create_stripe_customer(uid)
      customer = find_by(uid: uid)
      return customer if customer.present?

      stripe_customer = Stripe::Customer.create(
        {
          metadata: {
            payment_app_customer_uid: uid
          }
        }
      )
      create!(
        uid: uid,
        stripe_customer_id: stripe_customer.id
      )
    end
  end
end
