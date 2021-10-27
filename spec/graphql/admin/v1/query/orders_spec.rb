# require 'rails_helper'

# RSpec.describe 'Admin::V1::PaymentAppSchema query: orders', type: :graphql do
#   subject do
#     Admin::V1::PaymentAppSchema.execute(
#       query,
#       context: {},
#       variables: {}
#     ).to_h.deep_symbolize_keys
#   end

#   let(:user) { create(:user) }
#   let(:product1) { create(:product) }
#   let(:product2) { create(:product) }
#   let!(:order1) { create(:order, quantity: 1, product: product1, user: user) }
#   let!(:order2) { create(:order, quantity: 1, product: product2, user: user) }

#   let(:query) do
#     <<-GRAPHQL
#       query orders {
#         orders {
#           id
#           quantity
#           product {
#             id
#           }
#         }
#       }
#     GRAPHQL
#   end

#   it '正常なレスポンスを返す' do
#     aggregate_failures do
#       expect(subject[:data]).to eq(
#         {
#           orders: [
#             {
#               id: order1.id.to_s,
#               quantity: 1,
#               product: {
#                 id: product1.id.to_s
#               }
#             },
#             {
#               id: order2.id.to_s,
#               quantity: 1,
#               product: {
#                 id: product2.id.to_s
#               }
#             }
#           ]
#         }
#       )
#     end
#   end
# end
