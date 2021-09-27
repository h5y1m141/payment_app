import React  from 'react'
import { Elements } from '@stripe/react-stripe-js'

import { CartItemsComponent } from '../../components/CartItemsComponent'
import { CheckOutForm } from './CheckOutForm'


type Props = {
  onSubmit: (paymentMethod: any) => void
  stripePromise: any
}
export const OrderNewTemplate: React.VFC<Props> = ({ onSubmit, stripePromise }) => {
  return (
    <>
      <CartItemsComponent />
      <Elements stripe={stripePromise}>
        <CheckOutForm onSubmit={onSubmit} />
      </Elements>
    </>
  )
}