require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  describe '#full_address' do
    subject(:response) { shipping_address.full_address }

    let(:prefecture) { create(:prefecture, name: '北海道') }
    let(:shipping_address) { create(:shipping_address, prefecture: prefecture, address: '札幌市中央区南６条西', zipcode: '064-0806') }

    it '都道府県を含めた登録されてる住所が取得できる' do
      expect(response).to eq '北海道札幌市中央区南６条西'
    end
  end
end
