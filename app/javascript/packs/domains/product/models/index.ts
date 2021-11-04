import { fetchResources } from '../services'

export type Product = {
  id: number
  name: string
  price: number
  current_stock: number
}

type ResponseProduct = {
  products: Product[]
}

export const fetchProducts = async () => {
  const response = await fetchResources()
  const result: ResponseProduct = await response.json()
  return result.products
}
