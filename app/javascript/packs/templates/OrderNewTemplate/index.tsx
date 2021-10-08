import React from 'react'
import { Elements } from '@stripe/react-stripe-js'

import { CartItemsComponent } from '../../components/CartItemsComponent'
import { CheckOutForm } from './CheckOutForm'
import { loadStripe } from '@stripe/stripe-js/pure'

type Props = {
  onSubmit: (paymentMethod: any) => void
}

const getStripe = () => {
  if (process.env.REACT_APP_STRIPE_PUBLIC_KEY) {
    return loadStripe(process.env.REACT_APP_STRIPE_PUBLIC_KEY)
  }
  return null
}
export const OrderNewTemplate: React.VFC<Props> = ({ onSubmit }) => {
  return (
    <>
      <CartItemsComponent />
      <Elements stripe={getStripe()}>
        <CheckOutForm onSubmit={onSubmit} />
      </Elements>
    </>
  )
}
