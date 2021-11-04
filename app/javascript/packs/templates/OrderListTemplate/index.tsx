import React from 'react'
import { Order } from '../../domains/order/models'

type Props = {
  orders: Order[]
}
export const OrderListTemplate: React.VFC<Props> = ({ orders }) => {
  return (
    <>
      <h3>OrderListTemplate</h3>
    </>
  )
}
