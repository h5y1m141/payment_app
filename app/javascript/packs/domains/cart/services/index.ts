import { CartState } from '../../../components/providers/CartProvider'

type CreateOrderInput = {
  uid: string
  idToken: string
  totalPrice: number
  cartItems: CartState[]
  paymentMethod: any
  shippingAddress: {
    id: number
  }
}
export const createOrder = async ({
  uid,
  idToken,
  totalPrice,
  cartItems,
  paymentMethod,
  shippingAddress,
}: CreateOrderInput) => {
  const url = `${process.env.REACT_APP_ORIGIN}/customer_api/v1/orders`
  const data = {
    uid,
    total_price: totalPrice,
    cart_items: cartItems,
    payment_method: paymentMethod,
    shipping_address_id: shippingAddress.id,
  }
  const params = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${idToken}`,
    },
    body: JSON.stringify(data),
  }

  return await fetch(url, params)
}
