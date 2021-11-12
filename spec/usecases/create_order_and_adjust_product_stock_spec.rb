require 'rails_helper'

RSpec.describe CreateOrderAndAdjustProductStock, type: :model do
  describe '.execute' do
    let(:customer) { create(:customer) }
    let(:product) { create(:product, price: 1000) }

    before do
      create(:product_stock, product: product, stock: 2)
      striple_intent_spy = spy(Stripe::PaymentIntent) # rubocop:disable RSpec/VerifiedDoubles
      allow(Stripe::PaymentIntent).to receive(:create).and_return(striple_intent_spy)
    end

    context '既存の在庫数の範囲内で注文を受け付けた場合' do
      subject(:response) { described_class.execute(params) }

      let(:params) do
        {
          uid: customer.uid,
          total_price: 2000,
          payment_method: {
            id: 'payment_method_id',
            card: {
              brand: 'visa',
              exp_month: 1,
              exp_year: 2028,
              last4: 4242
            }
          },
          cart_items: [
            {
              subTotal: 2000,
              quantity: 1,
              product: {
                id: product.id,
                name: product.name,
                price: product.price
              }
            }
          ]
        }
      end

      it '在庫の履歴に関するデーターが2件登録される' do
        expect { response }.to change(ProductStock, :count).by(1)
      end
    end

    context '既存の在庫数の範囲以上の注文を受け付けた場合' do
      subject(:response) { described_class.execute(params) }

      let(:params) do
        {
          uid: customer.uid,
          total_price: 2000,
          payment_method: {
            id: 'payment_method_id',
            card: {
              brand: 'visa',
              exp_month: 1,
              exp_year: 2028,
              last4: 4242
            }

          },
          cart_items: [
            {
              subTotal: 2000,
              quantity: 3,
              product: {
                id: product.id,
                name: product.name,
                price: product.price
              }
            }
          ]
        }
      end

      it 'falseが返る' do
        expect(response).to eq false
      end
    end

    context '2人がほぼ同時に注文。1人目は在庫数以上に注文。もう1人は既存の在庫数の範囲内で注文を実施した場合', use_truncation: true do
      let(:params1) do
        {
          uid: customer.uid,
          total_price: 20_000,
          payment_method: {
            id: 'payment_method_id',
            card: {
              brand: 'visa',
              exp_month: 1,
              exp_year: 2028,
              last4: 4242
            }
          },
          cart_items: [
            {
              subTotal: 20_000,
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
      let(:params2) do
        {
          uid: another_customer.uid,
          total_price: 2000,
          payment_method: {
            id: 'payment_method_id',
            card: {
              brand: 'visa',
              exp_month: 1,
              exp_year: 2028,
              last4: 4242
            }
          },
          cart_items: [
            {
              subTotal: 2000,
              quantity: 1,
              product: {
                id: product.id,
                name: product.name,
                price: product.price
              }
            }
          ]
        }
      end
      let(:another_customer) { create(:customer) }

      it '在庫の履歴に関するデーターが1件登録される' do
        expect do
          threads = []
          threads << Thread.new do
            ActiveRecord::Base.connection_pool.with_connection do
              sleep 0.5
              described_class.execute(params1)
            end
          end
          threads << Thread.new do
            ActiveRecord::Base.connection_pool.with_connection do
              described_class.execute(params2)
            end
          end
          threads.each(&:join)
        end.to change(ProductStock, :count).by(1)
      end
    end
  end
end
