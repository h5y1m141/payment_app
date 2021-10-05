import React from 'react'
import { useStripe, useElements, CardElement } from '@stripe/react-stripe-js'
import { useForm } from 'react-hook-form'

type Props = {
  onSubmit: (paymentMethod: any) => void
}

export const CheckOutForm: React.VFC<Props> = ({ onSubmit }) => {
  const { handleSubmit } = useForm()
  const stripe = useStripe()
  const elements = useElements()
  const onStripeFormSubmit = async () => {
    if (!stripe || !elements) {
      return
    }

    const cardElement = elements.getElement(CardElement)
    if (cardElement) {
      const { error, paymentMethod } = await stripe.createPaymentMethod({
        type: 'card',
        card: cardElement,
      })
      if (error) {
        console.log('[error]', error)
      } else {
        console.log('[PaymentMethod]', paymentMethod)
        onSubmit(paymentMethod)
      }
    }
  }

  return (
    <>
      <form onSubmit={handleSubmit(onStripeFormSubmit)}>
        <CardElement />
        <button type="submit" disabled={!stripe}>
          注文する
        </button>
      </form>
    </>
  )
}
