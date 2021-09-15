class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  has_one :payment_customer, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :user_credit_cards, dependent: :destroy

  delegate :customer_id, to: :payment_customer
  delegate :first_name, :last_name, :full_name, to: :user_profile

  def current_credit_card_id
    return if user_credit_cards.length.zero?

    user_credit_cards.last.card_id
  end
end
