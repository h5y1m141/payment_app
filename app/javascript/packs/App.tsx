import React from 'react'
import { Grid, Box, ThemeProvider, createTheme } from '@material-ui/core'
import { BrowserRouter as Router, Switch, Route, Link } from 'react-router-dom'
import green from '@material-ui/core/colors/green'
import { OrderNew } from './pages/OrderNew'
import { Products } from './pages/products'
import { CartProvider } from './components/providers/CartProvider'
import { AuthProvider } from './components/providers/AuthProvider'

const theme = createTheme({
  palette: {
    primary: {
      main: green[500],
      contrastText: '#ffffff',
    },
    secondary: {
      main: green[300],
      contrastText: '#ffffff',
    },
  },
  typography: {
    fontSize: 12,
  },
})

export const App: React.VFC = () => {
  return (
    <>
      <ThemeProvider theme={theme}>
        <Box p={1}>
          <Router>
            <Grid
              container
              direction="row"
              justifyContent="flex-start"
              alignItems="flex-start"
            >
              <Grid item xs={6}>
                <Link to="/">Home</Link>
              </Grid>
              <Grid item xs={6}>
                <Link to="/sign_in">SignIn</Link>
              </Grid>
            </Grid>
            <Grid
              container
              direction="row"
              justifyContent="flex-start"
              alignItems="flex-start"
            >
              <Grid item xs={12}>
                <AuthProvider>
                  <Switch>
                    <Route path="/sign_in">
                      <OrderNew />
                    </Route>
                    <CartProvider>
                      <Route path="/products">
                        <Products />
                      </Route>
                      <Route path="/orders/new">
                        <OrderNew />
                      </Route>
                    </CartProvider>
                  </Switch>
                </AuthProvider>
              </Grid>
            </Grid>
          </Router>
        </Box>
      </ThemeProvider>
    </>
  )
}
