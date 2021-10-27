# require 'rails_helper'

# RSpec.describe 'Admin::Api::V2::Orders', type: :request do
#   let(:customer) { create(:customer) }
#   let!(:order1) { create(:order, customer: customer) }

#   describe 'GET /admin/api/v2/orders' do
#     it 'order一覧のJSONが得られる' do
#       get '/admin/api/v2/orders'
#       expect(JSON.parse(response.body)['orders'][0]['id']).to eq order1.id
#     end
#   end

#   describe 'GET /admin/api/v2/orders/:id' do
#     it 'orderのJSONが得られる' do
#       get "/admin/api/v2/orders/#{order1.id}"
#       expect(JSON.parse(response.body)['order']['id']).to eq order1.id
#     end
#   end

#   describe 'POST /admin/api/v2/orders' do
#     let(:product) { create(:product, price: 1_000) }
#     let(:order_params) do
#       {
#         total_price: 10_800,
#         payment_method: {
#           id: 'pi_1234567890',
#           card: {
#             brand: 'visa',
#             last4: '0123',
#             exp_month: 1,
#             exp_year: 2029
#           }
#         },
#         cart_items: [
#           {
#             subTotal: 10_000,
#             quantity: 10,
#             product: {
#               id: product.id,
#               name: product.name,
#               price: product.price
#             }
#           }
#         ]
#       }.to_json
#     end

#     before do
#       create(:product_stock, product: product, stock: 100)
#     end

#     it 'orderのtotal_priceの金額が得られる' do
#       post '/admin/api/v2/orders', params: order_params, headers: { 'Content-Type': 'application/json' }
#       result = JSON.parse(response.body)
#       expect(result['order']['total_price']).to eq 10_800
#     end
#   end
# end
