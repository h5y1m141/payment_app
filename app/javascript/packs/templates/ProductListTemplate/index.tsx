import React from 'react'
import { Grid, Typography } from '@material-ui/core'
import { Product } from '../../domains/product/models'
import { ProductItem } from './ProductItem'

type Props = {
  products: Product[]
  onSelectProduct: (product: Product) => void
}
export const ProductListTemplate: React.VFC<Props> = ({ products, onSelectProduct }) => {
  return (
    <>
      <Typography variant="h2">商品を購入</Typography>
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