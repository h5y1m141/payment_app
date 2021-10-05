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
  const response = await createResource(user.uid)
  return { uid: user.uid, status: response.status }
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
  return { uid: user.uid, status: 200 }
}

export const createResource = async (uid: string) => {
  const url = `${process.env.REACT_APP_ORIGIN}/admin/api/v2/customers`
  const data = {
    uid,
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
