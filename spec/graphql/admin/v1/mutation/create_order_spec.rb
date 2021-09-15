require 'rails_helper'

RSpec.describe 'Admin::V1::PaymentAppSchema mutation: createOrder', type: :graphql do
  subject do
    Admin::V1::PaymentAppSchema.execute(
      mutation,
      context: {},
      variables: {
        productId: product.id.to_s,
        userId: user.id.to_s,
        quantity: 1,
        amount: 10_000
      }
    ).to_h.deep_symbolize_keys
  end


  let!(:user) { create(:user) }
  let!(:product) { create(:product, price: 10_000) }
  let!(:product_stock) { create(:product_stock, product: product, stock: 2) }

  let(:mutation) do
    <<-GRAPHQL
      mutation createOrder($userId: ID!, $productId: ID!, $quantity: Int!, $amount: Int!) {
        createOrder(input: {productId: $productId, quantity: $quantity, amount: $amount, userId: $userId}) {
          order {
            quantity
            product {
              id
              name
            }
          }
        }
      }
    GRAPHQL
  end

  it '正常なレスポンスを返す' do
    aggregate_failures do
      expect(subject[:data]).to eq(
        {
          createOrder: {
            order: {
              quantity: 1,
              product: {
                id: product.id.to_s,
                name: product.name
              }
            }
          }
        }
      )
    end
  end
end
