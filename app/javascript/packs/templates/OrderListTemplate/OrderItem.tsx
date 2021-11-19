import React, { useState, useEffect } from 'react'
import { Box, Typography, Grid, Divider, Button } from '@material-ui/core'
import { Order } from '../../domains/order/models'

type Props = {
  order: Order
  onCancellationRequest: (order: Order) => void
}

type OrderStatusType = {
  status:
    | 'ShippingRequest'
    | 'ShippingInReady'
    | 'CancellationRequest'
    | 'CancellationComplete'
    | 'ShippingComplete'
  label: string
}
export const OrderItem: React.VFC<Props> = ({
  order,
  onCancellationRequest,
}) => {
  const OrderStatusMaster: OrderStatusType[] = [
    { status: 'ShippingRequest', label: '注文受付' },
    { status: 'ShippingInReady', label: '出荷準備完了' },
    { status: 'CancellationRequest', label: '注文・出荷キャンセル依頼中' },
    { status: 'CancellationComplete', label: '注文・出荷キャンセル完了' },
    { status: 'ShippingComplete', label: '出荷完了' },
  ]

  const [currentOrderStatus, setCurrentOrderStatus] = useState('')

  useEffect(() => {
    const orderStatus = OrderStatusMaster.find((item) => {
      return item.status === order.status
    })

    if (orderStatus) {
      setCurrentOrderStatus(orderStatus.label)
    }
  }, [order])

  return (
    <>
      <Box p={1}>
        <Grid container justifyContent="space-between" alignItems="center">
          <Grid item xs={12}>
            <Typography variant="h5">注文ID：{order.id}</Typography>
          </Grid>
          <Grid item xs={12}>
            <Typography variant="h6">
              注文ステータス：{currentOrderStatus}
            </Typography>
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
            order.orderItems.map((orderItem, index) => {
              return (
                <Grid
                  key={`${orderItem.productName}-${index}`}
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
            <Button
              onClick={() => onCancellationRequest(order)}
              variant="contained"
              color="secondary"
              disabled={
                [
                  'ShippingRequest',
                  'ShippingInReady',
                  'CancellationRequest',
                ].includes(order.status)
                  ? false
                  : true
              }
            >
              {order.status === 'ShippingInReady'
                ? '出荷取消を依頼'
                : '注文キャンセルを依頼'}
            </Button>
          </Grid>
          <Grid item xs={12}>
            <Box p={3}>
              <Divider />
            </Box>
          </Grid>
        </Grid>
      </Box>
    </>
  )
}
