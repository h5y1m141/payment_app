export type Customer = {
  id: number
  uid: string
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

export type CustomerSignUp = {
  email: string
  password: string
}
