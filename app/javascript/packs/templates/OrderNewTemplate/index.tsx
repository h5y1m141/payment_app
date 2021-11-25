import React, { useState, useEffect } from 'react'
import { Elements } from '@stripe/react-stripe-js'

import { CartItemsComponent } from '../../components/CartItemsComponent'
import { CheckOutForm } from './CheckOutForm'
import { loadStripe } from '@stripe/stripe-js/pure'
import {
  CustomerPaymentMethod,
  CustomerShippingAddress,
} from '../../domains/customer/models'
import { Snackbar } from '@material-ui/core'

type Props = {
  onSubmit: (paymentMethod: any, shippingAddress: any) => void
  customerPaymentMethods: CustomerPaymentMethod[]
  customerShippingAddresses: CustomerShippingAddress[]
  isOrderUnprocess: boolean
}

const getStripe = () => {
  if (process.env.REACT_APP_STRIPE_PUBLIC_KEY) {
    return loadStripe(process.env.REACT_APP_STRIPE_PUBLIC_KEY)
  }
  return null
}
export const OrderNewTemplate: React.VFC<Props> = ({
  onSubmit,
  customerPaymentMethods,
  customerShippingAddresses,
  isOrderUnprocess,
}) => {
  const [open, setOpen] = useState(false)

  useEffect(() => {
    setOpen(isOrderUnprocess)
  }, [isOrderUnprocess])

  return (
    <>
      <CartItemsComponent />

      <Elements stripe={getStripe()}>
        <CheckOutForm
          onSubmit={onSubmit}
          customerPaymentMethods={customerPaymentMethods}
          customerShippingAddresses={customerShippingAddresses}
        />
        <Snackbar
          open={open}
          autoHideDuration={3000}
          onClose={() => {
            setOpen(false)
          }}
          message="入力内容に不備があるため注文処理が完了出来ません"
        />
      </Elements>
    </>
  )
}
