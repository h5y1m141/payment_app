import React from 'react'
import { Grid, Box, Button, makeStyles } from '@material-ui/core'
import { Product } from '../../domains/product/models'


type Props = {
  product: Product
  onSelectProduct: (product: Product) => void
}
export const ProductItem: React.VFC<Props> = ({ product, onSelectProduct }) => {
  const classes = useStyles()

  return (
    <>
      <Box p={1}>
        <Grid container justifyContent="space-between" alignItems="center">
          <Grid item xs={12}>
            <img className={classes.image} src="https://via.placeholder.com/300x200.png" alt="商品画像" />
          </Grid>
          <Grid item xs={9}>
            {product.name}
          </Grid>
          <Grid item xs={3} className={classes.price}>
            {new Intl.NumberFormat('ja-JP', { style: 'currency', currency: 'JPY' }).format(product.price)}
          </Grid>

          <Grid item xs={12}>
            <Button
             variant="contained"
             color="primary"
             onClick={()=>{
              onSelectProduct(product)
            }}>詳細画面</Button>
          </Grid>
        </Grid>
      </Box>
    </>
  )
}

const useStyles = makeStyles((theme) => ({
  price: {
    textAlign: 'end'
  },
  image: {
    width: '100%',
    display: 'flex'
  },
}))
