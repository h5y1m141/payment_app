import React, { useEffect, useState, useCallback } from 'react'
import {
  Order,
  fetchOrders,
  createCancellationRequest,
} from '../../domains/order/models'
import { useCurrentCustomer } from '../../components/providers/AuthProvider'

import { OrderListTemplate } from '../../templates/OrderListTemplate'
import { Snackbar } from '@material-ui/core'

export const OrderList: React.VFC = () => {
  const [orders, setOrders] = useState<Order[]>([])
  const [isRefetch, setIsRefetch] = useState<boolean>(false)
  const [open, setOpen] = useState(false)
  const [currentCustomer] = useCurrentCustomer()
  const { idToken } = currentCustomer

  useEffect(() => {
    async function fetchData() {
      const result = await fetchOrders(idToken)
      setOrders(result)
    }
    fetchData()
  }, [])

  useEffect(() => {
    async function fetchData() {
      const result = await fetchOrders(idToken)
      setOrders(result)
    }
    fetchData()
  }, [isRefetch])

  const onCancellationRequest = useCallback(async (order: Order) => {
    console.log('onCancellationRequest')
    const result = await createCancellationRequest(idToken, order.id)
    if (result) {
      setIsRefetch(true)
      setOpen(true)
    }
  }, [])

  if (orders.length === 0) return <>Loading...</>

  return (
    <>
      <OrderListTemplate
        orders={orders}
        onCancellationRequest={onCancellationRequest}
      />
      <Snackbar
        open={open}
        autoHideDuration={3000}
        onClose={() => {
          setOpen(false)
        }}
        message="注文のキャンセルを受け付けました"
      />
    </>
  )
}
