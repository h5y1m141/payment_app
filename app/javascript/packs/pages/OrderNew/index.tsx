import React, { useCallback, useState, useContext } from 'react'
import { OrderNewTemplate } from '../../templates/OrderNewTemplate'
import { SignInRequiredTemplate } from '../../templates/OrderNewTemplate/SignInRequiredTemplate'

import {
  CartStateContext,
  initialCartState,
} from '../../components/providers/CartProvider'
import { AuthStateContext } from '../../components/providers/AuthProvider'
import { createOrder } from '../../domains/cart/services'
import { calcurateTotalPrice } from '../../domains/cart/models'
import { createCustomer, signInCustomer } from '../../domains/customer/services'
import { CustomerSignUp } from '../../domains/customer/models'

import { initializeApp } from 'firebase/app'
import { Redirect } from 'react-router-dom'

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
  const [cartItems, setCartItems] = useContext(CartStateContext)
  const [currentCustomer, setCurrentCustomer] = useContext(AuthStateContext)
  const [isOrderComplated, setIsOrderComplated] = useState(false)
  const totalPrice = calcurateTotalPrice()

  const onSubmit = useCallback(async (paymentMethod) => {
    const createdOrder = await createOrder({
      uid: currentCustomer.uid,
      totalPrice,
      cartItems,
      paymentMethod,
    })
    if (createdOrder) {
      setIsOrderComplated(true)
      setCartItems(initialCartState)
    }
  }, [])

  const onCreateCustomer = async (customer: CustomerSignUp) => {
    const result = await createCustomer(customer)

    if (result.uid) {
      setCurrentCustomer({
        uid: result.uid,
      })
    }
  }

  const onSignInCustomer = async (customer: CustomerSignUp) => {
    const result = await signInCustomer(customer)

    if (result.uid) {
      setCurrentCustomer({
        uid: result.uid,
      })
      console.log(currentCustomer.uid)
    }
  }

  if (isOrderComplated) return <Redirect to={'/products'} />

  if (!currentCustomer.uid)
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
      <OrderNewTemplate onSubmit={onSubmit} />
    </>
  )
}
