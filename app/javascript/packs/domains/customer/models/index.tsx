import {
  fetchPaymentMethodResources,
  fetchShippingAddressResources,
} from '../services'
export type Customer = {
  id: number
  uid: string
  idToken?: string
}

export type ResponseCustomerPaymentMethod = {
  customer_payment_methods: CustomerPaymentMethod[]
}

export type CustomerPaymentMethod = {
  id: number
  payment_method_id: string
  exp_month: number
  exp_year: number
  brand: string
}

export type ResponseCustomerShippingAddress = {
  customer_shipping_addresses: CustomerShippingAddress[]
}

export type CustomerShippingAddress = {
  id: number
  zipcode: string
  prefecture_name: string
  address: string
}

export type CustomerSignUp = {
  email: string
  password: string
}

export const fetchPaymentMethods = async (idToken: string) => {
  const response = await fetchPaymentMethodResources(idToken)
  const result: ResponseCustomerPaymentMethod = await response.json()
  return result.customer_payment_methods
}

export const fetchShippingAddresses = async (idToken: string) => {
  const response = await fetchShippingAddressResources(idToken)
  const result: ResponseCustomerShippingAddress = await response.json()
  return result.customer_shipping_addresses
}
