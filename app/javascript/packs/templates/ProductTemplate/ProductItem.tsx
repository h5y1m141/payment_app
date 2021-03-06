import React, { useState, useCallback, useContext } from 'react'
import { Grid, Box, Button, makeStyles, Typography } from '@material-ui/core'
import AddIcon from '@material-ui/icons/Add'
import MinimizeIcon from '@material-ui/icons/Minimize'
import { Product } from '../../domains/product/models'
import { calcurateCartItem } from '../../domains/cart/models/index'
import { CartStateContext } from '../../components/providers/CartProvider'

type Props = {
  product: Product
  resetSelectedProduct: () => void
}
export const ProductItem: React.VFC<Props> = ({
  product,
  resetSelectedProduct,
}) => {
  const [quantity, setQuantity] = useState(0)
  const [cartItems, setCartItems] = useContext(CartStateContext)
  const addToCart = useCallback(
    (selectedProduct) => {
      const { product, subTotal } = calcurateCartItem(selectedProduct, quantity)
      const newCartItem = {
        product,
        subTotal,
        quantity,
      }
      if (!cartItems[0].subTotal) {
        const newCartItems = [newCartItem]
        setCartItems(newCartItems)
      } else {
        const newCartItems = cartItems.concat([newCartItem])
        setCartItems(newCartItems)
      }

      resetSelectedProduct()
    },
    [quantity]
  )
  const increase = () => {
    if (quantity < product.current_stock) {
      const newNumberOfItem = quantity + 1
      setQuantity(newNumberOfItem)
    }
  }
  const decrease = () => {
    if (quantity !== 0) {
      const newNumberOfItem = quantity - 1
      setQuantity(newNumberOfItem)
    }
  }
  const classes = useStyles()

  return (
    <>
      <Box p={1}>
        <Grid container justifyContent="space-between" alignItems="center">
          <Grid item xs={9}>
            <img
              className={classes.image}
              src="https://via.placeholder.com/600x600.png"
              alt="メイン画像"
            />
          </Grid>
          <Grid item xs={3} className={classes.price}>
            <Typography variant="subtitle1">{product.name}</Typography>
            <Typography variant="subtitle1">
              在庫数：{product.current_stock}
            </Typography>
            <Typography variant="subtitle2">
              {new Intl.NumberFormat('ja-JP', {
                style: 'currency',
                currency: 'JPY',
              }).format(product.price)}
            </Typography>
            <Button onClick={increase}>
              <AddIcon />
            </Button>
            {quantity}
            <Button onClick={decrease}>
              <MinimizeIcon />
            </Button>
            {quantity > 0 && (
              <div>
                <Button
                  color="primary"
                  variant="contained"
                  onClick={() => {
                    addToCart(product)
                  }}
                >
                  この商品をカートに入れる
                </Button>
              </div>
            )}
            {quantity > product.current_stock && (
              <div>在庫数以上の注文は行なえません</div>
            )}
          </Grid>
          <Grid item xs={3}>
            <Box p={1}>
              <img
                className={classes.thumbnail}
                src="https://via.placeholder.com/150x150.png?text=Color+Red"
                alt="SKU1"
              />
            </Box>
          </Grid>
          <Grid item xs={3}>
            <Box p={1}>
              <img
                className={classes.thumbnail}
                src="https://via.placeholder.com/150x150.png?text=Color+Blue"
                alt="SKU2"
              />
            </Box>
          </Grid>
          <Grid item xs={3}>
            <Box p={1}>
              <img
                className={classes.thumbnail}
                src="https://via.placeholder.com/150x150.png?text=Color+Blue"
                alt="SKU3"
              />
            </Box>
          </Grid>
          <Grid item xs={3}>
            <Box p={1}>
              <img
                className={classes.thumbnail}
                src="https://via.placeholder.com/150x150.png?text=Color+white"
                alt="SKU4"
              />
            </Box>
          </Grid>
          <Grid item xs={12}>
            <Button
              variant="contained"
              color="secondary"
              onClick={() => {
                resetSelectedProduct()
              }}
            >
              一覧に戻る
            </Button>
          </Grid>
        </Grid>
      </Box>
    </>
  )
}

const useStyles = makeStyles((theme) => ({
  price: {
    textAlign: 'end',
  },
  image: {
    width: '600px',
    height: '600px',
    display: 'flex',
  },
  thumbnail: {
    width: '150px',
    height: '150px',
    display: 'flex',
  },
}))
