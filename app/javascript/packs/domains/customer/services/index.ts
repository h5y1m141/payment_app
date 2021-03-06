import {
  getAuth,
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
} from 'firebase/auth'
import { CustomerSignUp } from '../models'

export const createCustomer = async (customer: CustomerSignUp) => {
  const auth = getAuth()
  const userCredential = await createUserWithEmailAndPassword(
    auth,
    customer.email,
    customer.password
  )
  if (!userCredential) return { uid: null, status: 500 }

  const user = userCredential.user
  const idToken = await user.getIdToken()
  const response = await createResource(user.uid, idToken)
  return { uid: user.uid, idToken, status: response.status }
}

export const signInCustomer = async (customer: CustomerSignUp) => {
  const auth = getAuth()
  const userCredential = await signInWithEmailAndPassword(
    auth,
    customer.email,
    customer.password
  )
  if (!userCredential) return { uid: null, status: 500 }

  const user = userCredential.user
  const idToken = await user.getIdToken()
  return { uid: user.uid, idToken, status: 200 }
}

export const createResource = async (uid: string, idToken: string) => {
  const url = `${process.env.REACT_APP_ORIGIN}/customer_api/v1/customers`
  const data = {
    uid,
    id_token: idToken,
  }
  const params = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(data),
  }
  return await fetch(url, params)
}

export const fetchPaymentMethodResources = async (idToken: string) => {
  const url = `${process.env.REACT_APP_ORIGIN}/customer_api/v1/customer_payment_methods`
  return await fetch(url, {
    headers: {
      Authorization: `Bearer ${idToken}`,
    },
  })
}

export const fetchShippingAddressResources = async (idToken: string) => {
  const url = `${process.env.REACT_APP_ORIGIN}/customer_api/v1/customer_shipping_addresses`
  return await fetch(url, {
    headers: {
      Authorization: `Bearer ${idToken}`,
    },
  })
}
