require 'rails_helper'

RSpec.describe 'Admin::Api::V2::Products', type: :request do
  let!(:product) { create(:product, price: 1000) }
  let(:headers) do
    {
      'Content-Type': 'application/json'
    }
  end

  before do
    create(:product_stock, product: product, stock: 2)
  end

  describe 'GET /admin/api/v2/products' do
    subject do
      get '/admin/api/v2/products', params: {}, headers: headers
      JSON.parse(response.body)
    end

    it 'product一覧のJSONが得られる' do
      expect(subject['products'][0]['id']).to eq product.id
    end
  end

  describe 'GET /admin/api/v2/products/:id' do
    subject do
      get "/admin/api/v2/products/#{product.id}", params: {}, headers: headers
      JSON.parse(response.body)
    end

    it 'productのJSONが得られる' do
      expect(subject['id']).to eq product.id
    end
  end
end
