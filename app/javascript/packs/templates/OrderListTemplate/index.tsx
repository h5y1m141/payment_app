import React from 'react'
import { Grid } from '@material-ui/core'
import { Order } from '../../domains/order/models'
import { OrderItem } from './OrderItem'

type Props = {
  orders: Order[]
}
export const OrderListTemplate: React.VFC<Props> = ({ orders }) => {
  return (
    <>
      <Grid container>
        {orders.map((order) => {
          return (
            <Grid item xs={12}>
              <OrderItem key={order.id} order={order} />
            </Grid>
          )
        })}
      </Grid>
    </>
  )
}
