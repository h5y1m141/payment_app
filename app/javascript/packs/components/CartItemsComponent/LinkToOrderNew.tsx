import React from "react"
import { Grid, Typography } from "@material-ui/core"
import { Link } from 'react-router-dom'

export const LinkToOrderNew: React.VFC = () => {
  return (
    <>
      <Grid item xs={12}>
        <Link to="/orders/new">
          <Typography variant="subtitle1">
            購入画面に進む
          </Typography>
        </Link>
      </Grid>
    </>
  )
}