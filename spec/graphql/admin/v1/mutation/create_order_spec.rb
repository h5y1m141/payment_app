# require 'rails_helper'

# RSpec.describe 'Admin::V1::PaymentAppSchema mutation: createOrder', type: :graphql do
#   subject do
#     Admin::V1::PaymentAppSchema.execute(
#       mutation,
#       context: {},
#       variables: {
#         uid: customer.uid,
#         total_price: 2000,
#         payment_method: {
#           id: 'payment_method_id',
#           card: {
#             brand: 'visa',
#             exp_month: 1,
#             exp_year: 2028,
#             last4: 4242
#           }
#         },
#         cart_items: [
#           {
#             subTotal: 2000,
#             quantity: 1,
#             product: {
#               id: product.id,
#               name: product.name,
#               price: product.price
#             }
#           }
#         ]
#       }
#     ).to_h.deep_symbolize_keys
#   end

#   let(:product) { create(:product, price: 1000) }
#   let(:customer) { create(:customer) }
#   before do
#     create(:product_stock, product: product, stock: 2)
#     striple_intent_spy = spy(Stripe::PaymentIntent)
#     allow(Stripe::PaymentIntent).to receive(:create).and_return(striple_intent_spy)
#   end

#   let(:mutation) do
#     <<-GRAPHQL
#       mutation createOrder($userId: ID!, $productId: ID!, $quantity: Int!, $amount: Int!) {
#         createOrder(input: {productId: $productId, quantity: $quantity, amount: $amount, userId: $userId}) {
#           order {
#             quantity
#             product {
#               id
#               name
#             }
#           }
#         }
#       }
#     GRAPHQL
#   end
#   let!(:product) { create(:product, price: 10_000) }

#   before do
#     create(:product_stock, product: product, stock: 2)
#   end

#   it '正常なレスポンスを返す' do
#     aggregate_failures do
#       expect(subject[:data]).to eq(
#         {
#           createOrder: {
#             order: {
#               quantity: 1,
#               product: {
#                 id: product.id.to_s,
#                 name: product.name
#               }
#             }
#           }
#         }
#       )
#     end
#   end
# end
