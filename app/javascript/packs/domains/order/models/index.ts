import { fetchResources, createCancellationRequestResources } from '../services'

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

type CancellationOrderResponse = {
  shipping: {
    id: number
  }
}

export const fetchOrders = async (idToken: string) => {
  const response = await fetchResources(idToken)
  const result: OrderResponse = await response.json()
  return result.orders
}

export const createCancellationRequest = async (
  idToken: string,
  orderId: number
) => {
  const response = await createCancellationRequestResources(idToken, orderId)
  const result: CancellationOrderResponse = await response.json()
  return result.shipping
}
