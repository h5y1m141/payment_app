require 'rails_helper'

RSpec.describe 'Admin::V1::PaymentAppSchema mutation: createOrder', type: :graphql do
  subject do
    Admin::V1::PaymentAppSchema.execute(
      mutation,
      context: {},
      variables: {
        idToken: 'idToken',
        uid: customer.uid,
        totalPrice: 2000,
        paymentMethod: {
          id: 'payment_method_id',
          card: {
            brand: 'visa',
            expMonth: 1,
            expYear: 2028,
            last4: '4242'
          }
        },
        cartItems: [
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
    ).to_h.deep_symbolize_keys
  end

  let(:product) { create(:product, price: 1000) }
  let(:mutation) do
    <<-GRAPHQL
      mutation createOrder(
        $idToken: String!,
        $uid: String!,
        $totalPrice: Int!,
        $cartItems: [CartItemInput!]!,
        $paymentMethod: PaymentMethodInput!
      ) {
        createOrder(input: {idToken: $idToken, totalPrice: $totalPrice, uid: $uid, cartItems: $cartItems, paymentMethod: $paymentMethod}) {
          order {
            totalPrice
          }
        }
      }
    GRAPHQL
  end
  let(:customer) { create(:customer) }

  before do
    create(:product_stock, product: product, stock: 2)
    striple_payment_response = instance_double(
      'PaymentIntentResponse',
      { id: 'payment_intent_id' }
    )
    allow(Stripe::PaymentIntent).to receive(:create).and_return(striple_payment_response)
  end

  it '正常なレスポンスを返す' do
    aggregate_failures do
      expect(subject[:data]).to eq(
        {
          createOrder: {
            order: {
              totalPrice: 2000
            }
          }
        }
      )
    end
  end
end
