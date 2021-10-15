import React from 'react'
import {
  Grid,
  Box,
  Button,
  makeStyles,
  Typography,
  Tooltip,
} from '@material-ui/core'
import { Product } from '../../domains/product/models'
import WarningIcon from '@material-ui/icons/Warning'
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
            <img
              className={classes.image}
              src="https://via.placeholder.com/300x200.png"
              alt="商品画像"
            />
          </Grid>
          <Grid item xs={9}>
            {product.currnt_stock < 50 && (
              <Tooltip title="在庫が残りわずかです">
                <WarningIcon />
              </Tooltip>
            )}
            <Typography className={classes.productName} variant="h6">
              {product.name}
            </Typography>
          </Grid>
          <Grid item xs={3} className={classes.price}>
            <Typography variant="h6">
              {new Intl.NumberFormat('ja-JP', {
                style: 'currency',
                currency: 'JPY',
              }).format(product.price)}
            </Typography>
          </Grid>

          <Grid item xs={12}>
            <Button
              variant="contained"
              color="primary"
              onClick={() => {
                onSelectProduct(product)
              }}
            >
              詳細画面へ
            </Button>
          </Grid>
        </Grid>
      </Box>
    </>
  )
}

const useStyles = makeStyles((theme) => ({
  productName: {
    display: 'inline',
  },
  price: {
    textAlign: 'end',
  },
  image: {
    width: '100%',
    display: 'flex',
  },
}))
