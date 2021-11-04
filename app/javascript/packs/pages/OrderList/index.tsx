import React, { useEffect, useState } from 'react'
import { Order, fetchOrders } from '../../domains/order/models'
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

  if (orders.length === 0) return <>Loading...</>

  return <OrderListTemplate orders={orders} />
}
