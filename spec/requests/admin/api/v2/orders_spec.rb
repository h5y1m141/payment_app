require 'rails_helper'

RSpec.describe 'Admin::Api::V2::Orders', type: :request do
  let(:customer) { create(:customer) }
  let(:product) { create(:product, price: 1000) }
  let!(:order1) { create(:order, customer: customer) }
  let(:params) do
    {
      id_token: 'test'
    }
  end

  let(:headers) do
    {
      'Content-Type': 'application/json'
    }
  end

  before do
    create(:product_stock, product: product, stock: 2)
    striple_intent_spy = spy(Stripe::PaymentIntent) # rubocop:disable RSpec/VerifiedDoubles
    allow(Stripe::PaymentIntent).to receive(:create).and_return(striple_intent_spy)
    allow(AuthToken).to receive(:verify).and_return({ uid: 'valid-uid' }.deep_stringify_keys)
  end

  describe 'GET /admin/api/v2/orders' do
    subject do
      get '/admin/api/v2/orders', params: params, headers: headers
      JSON.parse(response.body)
    end

    it 'order一覧のJSONが得られる' do
      expect(subject['orders'][0]['id']).to eq order1.id
    end
  end

  describe 'GET /admin/api/v2/orders/:id' do
    subject do
      get "/admin/api/v2/orders/#{order1.id}", params: params, headers: headers
      JSON.parse(response.body)
    end

    it 'orderのJSONが得られる' do
      expect(subject['order']['id']).to eq order1.id
    end
  end

  describe 'POST /admin/api/v2/orders' do
    subject do
      post '/admin/api/v2/orders', params: params.merge(order_params).to_json, headers: headers
      JSON.parse(response.body)
    end

    let(:product) { create(:product, price: 1_000) }
    let(:order_params) do
      {
        total_price: 10_800,
        payment_method: {
          id: 'pi_1234567890',
          card: {
            brand: 'visa',
            last4: '0123',
            exp_month: 1,
            exp_year: 2029
          }
        },
        cart_items: [
          {
            subTotal: 10_000,
            quantity: 10,
            product: {
              id: product.id,
              name: product.name,
              price: product.price
            }
          }
        ]
      }
    end

    before do
      create(:product_stock, product: product, stock: 100)
    end

    it 'orderのtotal_priceの金額が得られる' do
      expect(subject['order']['total_price']).to eq 10_800
    end
  end
end
