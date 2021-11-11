import React from 'react'
import { Grid } from '@material-ui/core'
import { Order } from '../../domains/order/models'
import { OrderItem } from './OrderItem'

type Props = {
  orders: Order[]
  onCancellationRequest: (order: Order) => void
}
export const OrderListTemplate: React.VFC<Props> = ({
  orders,
  onCancellationRequest,
}) => {
  return (
    <>
      <Grid container>
        {orders.map((order) => {
          return (
            <div key={order.id}>
              <Grid item xs={12}>
                <OrderItem
                  key={order.id}
                  order={order}
                  onCancellationRequest={onCancellationRequest}
                />
              </Grid>
            </div>
          )
        })}
      </Grid>
    </>
  )
}
