import React, { useEffect, useState, useContext } from 'react'
import { fetchProducts, Product } from '../../domains/product/models'
import { ProductListTemplate } from '../../templates/ProductListTemplate'
import { ProductTemplate } from '../../templates/ProductTemplate'
import { CartItemsComponent } from '../../components/CartItemsComponent'
import { LinkToOrderNew } from '../../components/CartItemsComponent/LinkToOrderNew'
import { Typography } from '@material-ui/core'
import { CartStateContext } from '../../pages/CartProvider'

const initialProducts: Product[] = []
const initialProduct: Product = null

export const Products: React.VFC = () => {
  const [products, setProducts] = useState(initialProducts)
  const [selectedProduct, setSelectedProduct] = useState(initialProduct)
  const [cartItems] = useContext(CartStateContext)

  const onSelectProduct = (product: Product) => {
    setSelectedProduct(product)
  }

  const resetSelectedProduct = () => {
    setSelectedProduct(initialProduct)
  }

  const isCartItems = () => {
    return cartItems[0].product
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
      <CartItemsComponent />
      {isCartItems() && <LinkToOrderNew />}
    </>
  )
}
