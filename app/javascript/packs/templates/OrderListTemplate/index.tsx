import React from 'react'
import { Grid, Divider } from '@material-ui/core'
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
            <div key={order.id}>
              <Grid item xs={12}>
                <OrderItem order={order} />
              </Grid>
              <Grid item xs={12}>
                <Divider />
              </Grid>
            </div>
          )
        })}
      </Grid>
    </>
  )
}
