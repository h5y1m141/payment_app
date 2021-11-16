require 'rails_helper'

RSpec.describe 'Admin::Api::V2::CancellationOrders', type: :request do
  let(:customer) { create(:customer) }
  let!(:order1) { create(:order, customer: customer) }

  context '認証ユーザーからのリクエストの場合' do
    let(:headers) do
      {
        'Content-Type': 'application/json',
        Authorization: "Bearer #{customer.uid}"
      }
    end

    before do
      allow(AuthToken).to receive(:verify).and_return({ uid: customer.uid }.deep_stringify_keys)
      create(:shipping_state, order: order1)
    end

    describe 'POST /admin/api/v2/cancellation_orders' do
      subject do
        post '/admin/api/v2/cancellation_orders', params: order_params.to_json, headers: headers
        JSON.parse(response.body)
      end

      let(:order_params) do
        {
          order_id: order1.id
        }
      end

      it 'キャンセル受付に関連してshippingレコードが存在する' do
        expect(subject['shipping'].present?).to eq true
      end
    end
  end

  context 'id_tokenに何も設定されていないリクエストの場合' do
    let(:headers) do
      {
        'Content-Type': 'application/json'
      }
    end

    before do
      allow(AuthToken).to receive(:verify).and_return({ uid: 'valid-uid' }.deep_stringify_keys)
    end

    describe 'POST /admin/api/v2/cancellation_orders' do
      subject do
        JSON.parse(response.body)
      end

      let(:order_params) do
        {
          order_id: order1.id
        }
      end

      it 'キャンセル受付に関連してshippingレコードが存在する' do
        post '/admin/api/v2/cancellation_orders', params: order_params.to_json, headers: headers
        expect(response.status).to eq 401
      end
    end
  end
end
