import React, { useCallback, useState, useEffect } from 'react'
import { OrderNewTemplate } from '../../templates/OrderNewTemplate'
import { SignInRequiredTemplate } from '../../templates/OrderNewTemplate/SignInRequiredTemplate'

import {
  useCart,
  initialCartState,
} from '../../components/providers/CartProvider'
import { useCurrentCustomer } from '../../components/providers/AuthProvider'
import { createOrder } from '../../domains/cart/services'
import { fetchPaymentMethods } from '../../domains/customer/services'
import { calcurateTotalPrice } from '../../domains/cart/models'
import { createCustomer, signInCustomer } from '../../domains/customer/services'
import {
  CustomerPaymentMethod,
  ResponseCustomerPaymentMethod,
  CustomerSignUp,
} from '../../domains/customer/models'

import { Redirect } from 'react-router-dom'

const initialCustomerPaymentMethods: CustomerPaymentMethod[] = []

export const OrderNew: React.VFC = () => {
  const [cartItems, setCartItems] = useCart()
  const [currentCustomer, setCurrentCustomer] = useCurrentCustomer()
  const [isCustomerPaymentMethods, setIsCustomerPaymentMethods] =
    useState(false)
  const [customerPaymentMethods, setCustomerPaymentMethods] = useState(
    initialCustomerPaymentMethods
  )
  const [isOrderComplated, setIsOrderComplated] = useState(false)
  const [isOrderUnprocess, setIsOrderUnprocess] = useState(false)
  const totalPrice = calcurateTotalPrice()

  useEffect(() => {
    async function fetchData() {
      const response = await fetchPaymentMethods(currentCustomer.uid)
      const result: ResponseCustomerPaymentMethod = await response.json()
      if (result.customer_payment_methods) {
        setCustomerPaymentMethods(result.customer_payment_methods)
      }
      setIsCustomerPaymentMethods(true)
    }
    fetchData()
  }, [])

  const onSubmit = useCallback(
    async (paymentMethod) => {
      const { uid, idToken } = currentCustomer
      const createdOrder = await createOrder({
        uid,
        idToken,
        totalPrice,
        cartItems,
        paymentMethod,
      })

      if (createdOrder.status === 200) {
        setIsOrderComplated(true)
        setCartItems(initialCartState)
      } else {
        setIsOrderUnprocess(true)
      }
    },
    [currentCustomer]
  )

  const onCreateCustomer = async (customer: CustomerSignUp) => {
    const result = await createCustomer(customer)

    if (result.uid) {
      setCurrentCustomer({
        uid: result.uid,
        idToken: result.idToken,
      })
    }
  }

  const onSignInCustomer = async (customer: CustomerSignUp) => {
    const result = await signInCustomer(customer)

    if (result.uid) {
      setCurrentCustomer({
        uid: result.uid,
        idToken: result.idToken,
      })
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

  if (!isCustomerPaymentMethods) return <>Loading...</>

  return (
    <>
      <OrderNewTemplate
        onSubmit={onSubmit}
        customerPaymentMethods={customerPaymentMethods}
        isOrderUnprocess={isOrderUnprocess}
      />
    </>
  )
}
