import React, { createContext, useState } from 'react'
import { Product } from '../domains/product/models/index'

export type CartState = {
  product: Product
  subTotal: number
  quantity: number
}

export const initialCartState = [
  {
    product: null,
    subTotal: 0,
    quantity: 0,
  },
]

export const CartStateContext = createContext<
  [CartState[], (cartItems: CartState[]) => void]
>([initialCartState, () => {}])

export const CartProvider: React.FC = ({ children }) => {
  const [cartItems, setCartItems] = useState<CartState[]>(initialCartState)

  return (
    <>
      <CartStateContext.Provider value={[cartItems, setCartItems]}>
        <div>{children}</div>
      </CartStateContext.Provider>
    </>
  )
}