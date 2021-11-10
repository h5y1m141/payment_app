require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe '.request_list' do
    subject { described_class.request_list.count }

    context '注文受け付けだけが存在する場合' do
      before do
        order = create(:order, total_price: 1000)
        create(:shipping, :shipping_request, order: order)
      end

      it '抽出結果は1件になる' do
        expect(subject).to eq 1
      end
    end

    context '注文受け付けが2件、受注対応完了が1件存在する場合' do
      before do
        order1 = create(:order, total_price: 10_000)
        order2 = create(:order, total_price: 20_000)
        create(:shipping, :shipping_request, order: order1)
        create(:shipping, :shipping_in_ready, order: order1)
        create(:shipping, :shipping_request, order: order2)
      end

      it '抽出結果は1件になる' do
        expect(subject).to eq 1
      end
    end
  end

  describe '.in_ready_list' do
    subject { described_class.in_ready_list.count }

    context '受注対応完了だけが存在する場合' do
      before do
        order = create(:order, total_price: 1000)
        create(:shipping, :shipping_in_ready, order: order)
      end

      it '抽出結果は1件になる' do
        expect(subject).to eq 1
      end
    end

    context '受注対応完了が2件、出荷済が1件存在する場合' do
      before do
        order1 = create(:order, total_price: 10_000)
        order2 = create(:order, total_price: 20_000)
        create(:shipping, :shipping_in_ready, order: order1)
        create(:shipping, :shipping_complete, order: order1)
        create(:shipping, :shipping_in_ready, order: order2)
      end

      it '抽出結果は1件になる' do
        expect(subject).to eq 1
      end
    end
  end
end
