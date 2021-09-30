import React, { useCallback, useEffect, useState, useContext } from 'react'
import { OrderNewTemplate } from '../../templates/OrderNewTemplate'
import { CartStateContext } from '../../pages/CartProvider'
import { createOrder } from '../../domains/cart/services'
import { calcurateTotalPrice } from '../../domains/cart/models'
import { loadStripe, Stripe } from '@stripe/stripe-js'

const initialStripeObject: Stripe | null = null
export const OrderNew: React.VFC = () => {
  const [stripePromise, setStripePromise] = useState(initialStripeObject)
  const [cartItems] = useContext(CartStateContext)

  useEffect(() => {
    async function configStripe() {
      if (process.env.REACT_APP_STRIPE_PUBLIC_KEY) {
        const stripe = await loadStripe(process.env.REACT_APP_STRIPE_PUBLIC_KEY)
        setStripePromise(stripe)
      }
    }
    configStripe()
  }, [])
  const onSubmit = useCallback(async (paymentMethod) => {
    const totalPrice = calcurateTotalPrice()
    const createdOrder = await createOrder({
      totalPrice,
      cartItems,
      paymentMethod,
    })
    console.log(createdOrder)
  }, [])

  if (stripePromise === null) return <div>Loading...</div>

  return (
    <>
      <OrderNewTemplate onSubmit={onSubmit} stripePromise={stripePromise} />
    </>
  )
}
