import React, { useCallback, useState, useContext, useEffect } from 'react'
import { OrderNewTemplate } from '../../templates/OrderNewTemplate'
import { SignInRequiredTemplate } from '../../templates/OrderNewTemplate/SignInRequiredTemplate'

import {
  CartStateContext,
  initialCartState,
} from '../../components/providers/CartProvider'
import { AuthStateContext } from '../../components/providers/AuthProvider'
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
  const [cartItems, setCartItems] = useContext(CartStateContext)
  const [currentCustomer, setCurrentCustomer] = useContext(AuthStateContext)
  const [isCustomerPaymentMethods, setIsCustomerPaymentMethods] =
    useState(false)
  const [customerPaymentMethods, setCustomerPaymentMethods] = useState(
    initialCustomerPaymentMethods
  )
  const [isOrderComplated, setIsOrderComplated] = useState(false)
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

  if (!isCustomerPaymentMethods) return <>Loading...</>

  return (
    <>
      <OrderNewTemplate
        onSubmit={onSubmit}
        customerPaymentMethods={customerPaymentMethods}
      />
    </>
  )
}
