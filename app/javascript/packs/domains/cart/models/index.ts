import { useContext } from 'react'
import { Product } from '../../product/models'
import { CartStateContext } from '../../../pages/CartProvider'
export type CartItem = {
  product: Product
  subTotal: number
}

const salesTaxRate = 1.08

export const currentSubTotals = () => {
  const [cartItems] = useContext(CartStateContext)
  const result = cartItems.map((item) => {
    return item.subTotal
  })
  return result
}

export const calcurateCartItem = (
  product: Product,
  quantity: number
): CartItem => {
  const calcuratePrice = product.price * quantity

  return {
    product: product,
    subTotal: Math.ceil(calcuratePrice * salesTaxRate),
  }
}

export const calcurateTotalPrice = () => {
  const totalPrice = currentSubTotals().reduce((previousItem, currentItem) => {
    return previousItem + currentItem
  }, 0)

  return totalPrice
}
