require 'rails_helper'

RSpec.describe 'Api::V2::Orders', type: :request do
  let(:customer) { create(:customer) }
  let!(:order1) { create(:order, customer: customer) }

  before do
    create(:shipping, order: order1)
  end

  describe 'GET /api/v2/orders' do
    it 'order一覧のJSONが得られる' do
      get '/api/v2/orders'
      expect(JSON.parse(response.body)[0]['id']).to eq order1.id
    end
  end
end
