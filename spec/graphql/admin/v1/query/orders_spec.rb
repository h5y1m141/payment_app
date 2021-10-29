require 'rails_helper'

RSpec.describe 'Admin::V1::PaymentAppSchema query: orders', type: :graphql do
  subject do
    Admin::V1::PaymentAppSchema.execute(
      query,
      context: {},
      variables: {}
    ).to_h.deep_symbolize_keys
  end

  let(:customer) { create(:customer) }
  let!(:order1) { create(:order, total_price: 10_000, customer_id: customer.id) }
  let!(:order2) { create(:order, total_price: 10_000, customer_id: customer.id) }

  let(:query) do
    <<-GRAPHQL
      query orders {
        orders {
          id
          totalPrice
        }
      }
    GRAPHQL
  end

  it '正常なレスポンスを返す' do
    aggregate_failures do
      expect(subject[:data]).to eq(
        {
          orders: [
            {
              id: order1.id.to_s,
              totalPrice: 10_000
            },
            {
              id: order2.id.to_s,
              totalPrice: 10_000
            }
          ]
        }
      )
    end
  end
end
