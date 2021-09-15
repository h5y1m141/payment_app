require 'rails_helper'

RSpec.describe 'Admin::V1::PaymentAppSchema query: product', type: :graphql do
  subject do
    Admin::V1::PaymentAppSchema.execute(
      query,
      context: {},
      variables: { id: product1.id.to_s }
    ).to_h.deep_symbolize_keys
  end

  let!(:product1) { create(:product, name: '商品1', price: 10_000) }

  let(:query) do
    <<-GRAPHQL
      query product($id: ID!) {
        product(id: $id) {
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
          product: {
            id: product1.id.to_s,
            name: '商品1',
            price: 10_000
          }
        }
      )
    end
  end
end
