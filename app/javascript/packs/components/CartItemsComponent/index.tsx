import React, { useContext } from "react"
import { Grid, Typography } from "@material-ui/core"
import { CartStateContext } from "../../pages/CartProvider"


export const CartItemsComponent: React.VFC = () => {
  const [cartItems] = useContext(CartStateContext)

  const isCartItems = () => {
    return cartItems[0].product
  }

  return (
    <>
      {isCartItems() && (
        <>
          <Grid item xs={12}>
          <Typography variant="subtitle1">
            カートの詳細:
            </Typography>
            {cartItems.map((cartItem) => {
              return (
                <div key={cartItem.product.id}>
                  <Typography variant="subtitle2">
                    {cartItem.product.name}
                  </Typography>
                  <Typography variant="subtitle2">
                    {new Intl.NumberFormat("ja-JP", {
                      style: "currency",
                      currency: "JPY",
                    }).format(cartItem.subTotal)}
                  </Typography>
                </div>
              )
            })}
          </Grid>
        </>
      )}
    </>
  );
};
