import { fetchResources } from '../services'

export type Order = {
  id: number
  totalPrice: number
  orderItems: OrderItem[]
  status: 'ShippingRequest' | 'ShippingInReady' | 'ShippingComplete'
}

type OrderItem = {
  productName: string
  productUnitPrice: number
  quantity: number
}

type OrderResponse = {
  orders: Order[]
}

export const fetchOrders = async (idToken: string) => {
  const response = await fetchResources(idToken)
  const result: OrderResponse = await response.json()
  return result.orders
}
