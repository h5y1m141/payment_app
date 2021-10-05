import React, { useCallback, useEffect, useState, useContext } from 'react'
import { OrderNewTemplate } from '../../templates/OrderNewTemplate'
import { SignInRequiredTemplate } from '../../templates/OrderNewTemplate/SignInRequiredTemplate'

import { CartStateContext } from '../../pages/CartProvider'
import { createOrder } from '../../domains/cart/services'
import { calcurateTotalPrice } from '../../domains/cart/models'
import { createCustomer, signInCustomer } from '../../domains/customer/services'
import { CustomerSignUp } from '../../domains/customer/models'

import { Stripe } from '@stripe/stripe-js'
import { loadStripe } from '@stripe/stripe-js/pure'
import { getAuth } from 'firebase/auth'
import { initializeApp } from 'firebase/app'

const firebaseConfig = {
  apiKey: process.env.REACT_APP_API_KEY,
  authDomain: process.env.REACT_APP_AUTH_DOMAIN,
  databaseURL: process.env.REACT_APP_DATABASE_URL,
  projectId: process.env.REACT_APP_PROJECT_ID,
  storageBucket: process.env.REACT_APP_STORAGE_BUCKET,
  messagingSenderId: process.env.REACT_APP_MESSAGING_SENDER_ID,
  appId: process.env.REACT_APP_APP_ID,
  measurementId: process.env.REACT_APP_MEASUREMENT_ID,
}

initializeApp(firebaseConfig)

export const OrderNew: React.VFC = () => {
  const auth = getAuth()
  const [stripePromise, setStripePromise] = useState<Stripe | null>()
  const [cartItems] = useContext(CartStateContext)
  const [currentUID, setCurrentUID] = useState('')

  useEffect(() => {
    async function configStripe() {
      if (process.env.REACT_APP_STRIPE_PUBLIC_KEY) {
        const stripe = await loadStripe(process.env.REACT_APP_STRIPE_PUBLIC_KEY)
        setStripePromise(stripe)
      }
    }
    configStripe()
  }, [])

  console.log(auth.currentUser?.uid)

  useEffect(() => {
    console.log('auth.currentUser')
    console.log(auth.currentUser)
    if (auth.currentUser?.uid) {
      setCurrentUID(auth.currentUser?.uid)
    }
  }, [auth])

  const onSubmit = useCallback(async (paymentMethod) => {
    const totalPrice = calcurateTotalPrice()
    const createdOrder = await createOrder({
      totalPrice,
      cartItems,
      paymentMethod,
    })
    console.log(createdOrder)
  }, [])

  const onCreateCustomer = async (customer: CustomerSignUp) => {
    const result = await createCustomer(customer)

    if (result.uid) {
      setCurrentUID(result.uid)
    }
  }

  const onSignInCustomer = async (customer: CustomerSignUp) => {
    const result = await signInCustomer(customer)

    if (result.uid) {
      setCurrentUID(result.uid)
    }
  }

  if (stripePromise === null) return <div>Loading...</div>

  if (!currentUID)
    return (
      <>
        <SignInRequiredTemplate
          onSignInCustomer={onSignInCustomer}
          onCreateCustomer={onCreateCustomer}
        />
      </>
    )

  return (
    <>
      <OrderNewTemplate onSubmit={onSubmit} stripePromise={stripePromise} />
    </>
  )
}
