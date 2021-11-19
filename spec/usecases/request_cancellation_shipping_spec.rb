require 'rails_helper'

RSpec.describe RequestCancellationShipping, type: :model do
  describe '.execute' do
    let(:customer) { create(:customer) }
    let(:product) { create(:product, price: 1000) }
    let(:order) { create(:order, customer: customer) }
    let!(:shipping_state) { create(:shipping_state, order: order) }

    before do
      create(:product_stock, product: product, stock: 2)
      create(:order_item, order_id: order.id,
                          product_name: product.name,
                          product_unit_price: product.price,
                          quantity: 1)
    end

    context '注文の状態が受付完了の場合' do
      subject(:response) { described_class.execute(order.id) }

      it 'shipping_stateの状態はship_cancel_requestになる' do
        expect(response.cancellation_request?).to eq true
      end
    end

    context '注文の状態が出荷準備完了の場合' do
      subject(:response) { described_class.execute(order.id) }

      before do
        shipping_state.shipping_in_ready!
      end

      it 'shipping_stateの状態はship_cancel_requestになる' do
        expect(response.cancellation_request?).to eq true
      end
    end

    context '注文の状態が出荷済の場合' do
      subject(:response) { described_class.execute(order.id) }

      before do
        shipping_state.shipping_in_ready!
        shipping_state.shipping_complete!
      end

      it 'AASM::InvalidTransitionの例外が発生する' do
        expect { response }.to raise_error AASM::InvalidTransition
      end
    end
  end
end
