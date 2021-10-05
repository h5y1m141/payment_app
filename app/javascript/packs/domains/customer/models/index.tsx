export type Customer = {
  id: number
  uid: string
}

type CustomerProduct = {
  customer: Customer
}

export type CustomerSignUp = {
  email: string
  password: string
}
