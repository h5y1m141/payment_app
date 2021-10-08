import { CartState } from '../../../components/providers/CartProvider'

type CreateOrderInput = {
  totalPrice: number
  cartItems: CartState[]
  paymentMethod: any
}
export const createOrder = async ({
  totalPrice,
  cartItems,
  paymentMethod,
}: CreateOrderInput) => {
  const url = `${process.env.REACT_APP_ORIGIN}/admin/api/v2/orders`
  const data = {
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
  console.log('params')
  console.log(params)
  return await fetch(url, params)
}
