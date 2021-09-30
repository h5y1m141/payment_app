import React from 'react'
import { Grid } from '@material-ui/core'
import { Product } from '../../domains/product/models'
import { ProductItem } from './ProductItem'

type Props = {
  product: Product
  resetSelectedProduct: () => void
}
export const ProductTemplate: React.VFC<Props> = ({
  product,
  resetSelectedProduct,
}) => {
  return (
    <>
      <Grid container>
        <Grid key={product.name} item xs={12}>
          <ProductItem
            product={product}
            resetSelectedProduct={resetSelectedProduct}
          />
        </Grid>
      </Grid>
    </>
  )
}
