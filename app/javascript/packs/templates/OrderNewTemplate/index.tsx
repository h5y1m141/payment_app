import React from 'react'
import { Elements } from '@stripe/react-stripe-js'

import { CartItemsComponent } from '../../components/CartItemsComponent'
import { CheckOutForm } from './CheckOutForm'
import { loadStripe } from '@stripe/stripe-js/pure'
import { CustomerPaymentMethod } from '../../domains/customer/models'

type Props = {
  onSubmit: (paymentMethod: any) => void
  customerPaymentMethods: CustomerPaymentMethod[]
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
}) => {
  return (
    <>
      <CartItemsComponent />
      <Elements stripe={getStripe()}>
        <CheckOutForm
          onSubmit={onSubmit}
          customerPaymentMethods={customerPaymentMethods}
        />
      </Elements>
    </>
  )
}
