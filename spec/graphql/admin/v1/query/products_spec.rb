require 'rails_helper'

RSpec.describe 'Admin::V1::PaymentAppSchema query: products', type: :graphql do
  subject do
    Admin::V1::PaymentAppSchema.execute(
      query,
      context: {},
      variables: {}
    ).to_h.deep_symbolize_keys
  end

  let!(:product1) { create(:product, name: '商品1', price: 10_000) }
  let!(:product2) { create(:product, name: '商品2', price: 20_000) }

  let(:query) do
    <<-GRAPHQL
      query products {
        products {
          id
          name
          price
        }
      }
    GRAPHQL
  end

  it '正常なレスポンスを返す' do
    aggregate_failures do
      expect(subject[:data]).to eq(
        {
          products: [
            {
              id: product1.id.to_s,
              name: '商品1',
              price: 10_000
            },
            {
              id: product2.id.to_s,
              name: '商品2',
              price: 20_000
            }
          ]
        }
      )
    end
  end
end
