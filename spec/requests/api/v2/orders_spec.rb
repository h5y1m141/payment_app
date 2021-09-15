require 'rails_helper'

RSpec.describe "Api::V2::Orders", type: :request do
  let(:user) { create(:user) }
  let(:product1) { create(:product) }
  let(:product2) { create(:product) }  
  let!(:order1) { create(:order, product: product1, user: user) }
  let!(:order2) { create(:order, product: product1, user: user) }


  describe "GET /api/v2/orders" do
    it 'order一覧のJSONが得られる' do
      get '/api/v2/orders'
      expect(JSON.parse(response.body)[0]["id"]).to eq order1.id
      expect(JSON.parse(response.body)[1]["id"]).to eq order2.id
    end
  end
end
