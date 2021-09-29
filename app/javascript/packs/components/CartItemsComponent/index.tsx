import React, { useContext } from "react"
import { Box, Grid, Typography } from "@material-ui/core"
import { CartStateContext } from "../../pages/CartProvider"
import { calcurateTotalPrice } from '../../domains/cart/models'


export const CartItemsComponent: React.VFC = () => {
  const [cartItems] = useContext(CartStateContext)

  const isCartItems = () => {
    return cartItems[0].product
  }

  return (
    <>
      {isCartItems() && (
        <Grid container>
          <Grid item xs={12}>
            <Typography variant="h5">
              カートの詳細:
            </Typography>
            {cartItems.map((cartItem) => {
              return (
                <div key={cartItem.product.id}>
                  <Typography variant="h6">
                    商品名：{cartItem.product.name}
                  </Typography>
                  <Typography variant="h6">
                    個数：{cartItem.quantity}
                  </Typography>
                  <Typography variant="h6">
                    小計：{new Intl.NumberFormat("ja-JP", {
                      style: "currency",
                      currency: "JPY",
                    }).format(cartItem.subTotal)}
                  </Typography>
                  <hr />
                </div>
              )
            })}
          </Grid>
          <Grid item xs={12}>
            <Box p={1} />
          </Grid>
          <Grid item xs={12}>
            <Typography variant="h5">
              合計金額: { new Intl.NumberFormat("ja-JP",
              {
                style: "currency",
                currency: "JPY",
              }).format(calcurateTotalPrice()) }
            </Typography>
          </Grid>
        </Grid>
      )}
    </>
  );
};
