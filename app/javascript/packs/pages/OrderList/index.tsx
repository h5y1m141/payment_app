import React, { useEffect, useState, useCallback } from 'react'
import {
  Order,
  fetchOrders,
  createCancellationRequest,
} from '../../domains/order/models'
import { useCurrentCustomer } from '../../components/providers/AuthProvider'

import { OrderListTemplate } from '../../templates/OrderListTemplate'

export const OrderList: React.VFC = () => {
  const [orders, setOrders] = useState<Order[]>([])
  const [currentCustomer] = useCurrentCustomer()
  const { idToken } = currentCustomer

  useEffect(() => {
    async function fetchData() {
      const result = await fetchOrders(idToken)
      setOrders(result)
    }
    fetchData()
  }, [])

  const onCancellationRequest = useCallback(async (order: Order) => {
    const result = await createCancellationRequest(idToken, order)
    console.log(result)
  }, [])

  if (orders.length === 0) return <>Loading...</>

  return (
    <OrderListTemplate
      orders={orders}
      onCancellationRequest={onCancellationRequest}
    />
  )
}
