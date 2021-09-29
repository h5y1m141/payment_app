import React from 'react'
import { Grid } from '@material-ui/core'
import { Product } from '../../domains/product/models'
import { ProductItem } from './ProductItem'

type Props = {
  products: Product[]
  onSelectProduct: (product: Product) => void
}
export const ProductListTemplate: React.VFC<Props> = ({ products, onSelectProduct }) => {
  return (
    <>
      <Grid container>
        {products.map((product) => {
          return (
            <Grid key={product.id} item xs={4}>
              <ProductItem product={product} onSelectProduct={onSelectProduct} />
            </Grid>
          )
        })}
      </Grid>
    </>
  )
}