import { CartState } from '../../../components/providers/CartProvider'

type CreateOrderInput = {
  uid: string
  totalPrice: number
  cartItems: CartState[]
  paymentMethod: any
}
export const createOrder = async ({
  uid,
  totalPrice,
  cartItems,
  paymentMethod,
}: CreateOrderInput) => {
  const url = `${process.env.REACT_APP_ORIGIN}/admin/api/v2/orders`
  const data = {
    uid,
    total_price: totalPrice,
    cart_items: cartItems,
    payment_method: paymentMethod,
  }
  const params = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(data),
  }

  return await fetch(url, params)
}
