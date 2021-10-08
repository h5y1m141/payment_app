import React, { useEffect, useState, useContext } from 'react'
import { fetchProducts, Product } from '../../domains/product/models'
import { ProductListTemplate } from '../../templates/ProductListTemplate'
import { ProductTemplate } from '../../templates/ProductTemplate'
import { CartItemsComponent } from '../../components/CartItemsComponent'
import { CartStateContext } from '../../components/providers/CartProvider'
import { LinkToOrderNew } from '../../components/CartItemsComponent/LinkToOrderNew'
import { Typography } from '@material-ui/core'

const initialProducts: Product[] = []

export const Products: React.VFC = () => {
  const [products, setProducts] = useState(initialProducts)
  const [selectedProduct, setSelectedProduct] = useState<Product | null>(null)
  const [cartItems] = useContext(CartStateContext)

  const isCartItems = () => {
    if (cartItems.length === 0) return false

    return cartItems[0].quantity !== 0
  }

  const onSelectProduct = (product: Product) => {
    if (product) {
      setSelectedProduct(product)
    }
  }

  const resetSelectedProduct = () => {
    setSelectedProduct(null)
  }

  useEffect(() => {
    async function fetchData() {
      const result = await fetchProducts()
      setProducts(result)
    }
    fetchData()
  }, [])

  if (selectedProduct !== null)
    return (
      <ProductTemplate
        product={selectedProduct}
        resetSelectedProduct={resetSelectedProduct}
      />
    )

  return (
    <>
      <Typography variant="h3">商品一覧</Typography>
      <ProductListTemplate
        products={products}
        onSelectProduct={onSelectProduct}
      />
      {isCartItems() && <CartItemsComponent />}
      {isCartItems() && <LinkToOrderNew />}
    </>
  )
}
