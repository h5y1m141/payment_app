import React from 'react'
import { Box, Typography, Grid, Divider } from '@material-ui/core'
import { Order } from '../../domains/order/models'

type Props = {
  order: Order
}
export const OrderItem: React.VFC<Props> = ({ order }) => {
  const orderStatus =
    order.status === 'ShippingRequest'
      ? '注文受付'
      : order.status === 'ShippingInReady'
      ? '出荷準備完了'
      : '出荷完了'
  return (
    <>
      <Box p={1}>
        <Grid container justifyContent="space-between" alignItems="center">
          <Grid item xs={12}>
            <Typography variant="h5">注文ID：{order.id}</Typography>
          </Grid>
          <Grid item xs={12}>
            <Typography variant="h6">注文ステータス：{orderStatus}</Typography>
          </Grid>
          <Grid item xs={12}>
            <Typography variant="h6">
              注文合計金額：
              {new Intl.NumberFormat('ja-JP', {
                style: 'currency',
                currency: 'JPY',
              }).format(order.totalPrice)}
            </Typography>
          </Grid>
          {order.orderItems.length > 0 &&
            order.orderItems.map((orderItem) => {
              return (
                <Grid
                  key={orderItem.productName}
                  container
                  justifyContent="flex-start"
                  alignItems="center"
                >
                  <Grid item xs={12}>
                    <Typography variant="h6">
                      ・{orderItem.productName}（
                      {new Intl.NumberFormat('ja-JP', {
                        style: 'currency',
                        currency: 'JPY',
                      }).format(orderItem.productUnitPrice)}
                      ｘ{orderItem.quantity}個）
                    </Typography>
                  </Grid>
                </Grid>
              )
            })}
          <Grid item xs={12}>
            <Divider />
          </Grid>
        </Grid>
      </Box>
    </>
  )
}
