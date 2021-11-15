require 'rails_helper'

RSpec.describe FixCancellationShipping, type: :model do
  describe '.execute' do
    let(:customer) { create(:customer) }
    let(:product) { create(:product, price: 1000) }
    let!(:order) { create(:order, total_price: 10_000, customer_id: customer.id) }

    before do
      create(:product_stock, product: product, stock: 2)
      create(:order_item, order_id: order.id, product_name: product.name, product_unit_price: product.price,
                          quantity: 1)
      create(:shipping, :shipping_in_ready, order: order)
      create(:shipping, :cancellation_request, order: order)
      striple_intent_spy = spy(Stripe::PaymentIntent) # rubocop:disable RSpec/VerifiedDoubles
      allow(Stripe::PaymentIntent).to receive(:create).and_return(striple_intent_spy)
    end

    context '既存の在庫数の範囲内で注文を受け付けた場合' do
      subject(:response) { described_class.execute(order.id) }

      it '在庫の履歴に関するデーターが1件登録される' do
        expect { response }.to change(ProductStock, :count).by(1)
      end
    end
  end
end