import React from 'react'
import { Box, Typography, Grid } from '@material-ui/core'
import { Order } from '../../domains/order/models'

type Props = {
  order: Order
}
export const OrderItem: React.VFC<Props> = ({ order }) => {
  return (
    <>
      <Box p={1}>
        <Grid container justifyContent="space-between" alignItems="center">
          <Grid item xs={12}>
            <Typography variant="h4">注文ID：{order.id}</Typography>
          </Grid>
          <Grid item xs={12}>
            <Typography variant="h4">
              注文合計金額：{order.totalPrice}
            </Typography>
          </Grid>
          <Grid item xs={12}>
            <Typography variant="h4">注文詳細</Typography>
          </Grid>
          {order.orderItems.length > 0 &&
            order.orderItems.map((orderItem) => {
              return (
                <>
                  <Grid item xs={12}>
                    <Typography variant="h6">
                      {orderItem.productName}
                    </Typography>
                  </Grid>
                  <Grid item xs={12}>
                    <Typography variant="h6">
                      {orderItem.productUnitPrice}
                    </Typography>
                  </Grid>
                  <Grid item xs={12}>
                    <Typography variant="h6">{orderItem.quantity}</Typography>
                  </Grid>
                </>
              )
            })}
        </Grid>
      </Box>
    </>
  )
}
