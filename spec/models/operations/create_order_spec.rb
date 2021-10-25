require 'rails_helper'

RSpec.describe Operations::CreateOrder, type: :model do
  describe '.execute' do
    let(:user) { create(:user) }
    let(:product) { create(:product, price: 1000) }

    before { create(:product_stock, product: product, stock: 2) }

    context '既存の在庫数の範囲内で注文を受け付けた場合' do
      subject(:response) { described_class.execute(params) }

      let(:params) do
        {
          user_id: user.id,
          product_id: product.id,
          quantity: 2,
          amount: 2000
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
          user_id: user.id,
          product_id: product.id,
          quantity: 3,
          amount: 2000
        }
      end

      it 'falseが返る' do
        expect(response).to eq false
      end
    end

    context '2人が同時に既存の在庫数の範囲内で注文を実施した場合', use_truncation: true do
      let(:params1) do
        {
          user_id: user.id,
          product_id: product.id,
          quantity: 1,
          amount: 2000
        }
      end
      let(:params2) do
        {
          user_id: another_user.id,
          product_id: product.id,
          quantity: 1,
          amount: 2000
        }
      end
      let(:another_user) { create(:user) }

      it '在庫の履歴に関するデーターが2件登録される' do
        expect do
          threads = []
          threads << Thread.new do
            ActiveRecord::Base.connection_pool.with_connection do
              described_class.execute(params1)
            end
          end
          threads << Thread.new do
            ActiveRecord::Base.connection_pool.with_connection do
              described_class.execute(params2)
            end
          end
          threads.each(&:join)
        end.to change(ProductStock, :count).by(2)
      end
    end

    context '2人がほぼ同時に注文。1人目は在庫数以上に注文。もう1人は既存の在庫数の範囲内で注文を実施した場合', use_truncation: true do
      let(:params1) do
        {
          user_id: user.id,
          product_id: product.id,
          quantity: 10,
          amount: 2000
        }
      end
      let(:params2) do
        {
          user_id: another_user.id,
          product_id: product.id,
          quantity: 1,
          amount: 2000
        }
      end
      let(:another_user) { create(:user) }

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
