import React from 'react'
import { Grid, Box, ThemeProvider, createTheme } from '@material-ui/core'
import { BrowserRouter as Router, Switch, Route, Link } from 'react-router-dom'
import green from '@material-ui/core/colors/green'
import { OrderNew } from './pages/OrderNew'
import { Products } from './pages/products'
import { MyPage } from './pages/MyPage'
import { CartProvider } from './components/providers/CartProvider'
import { PageHeader } from './components/PageHeader'
import { AuthProvider } from './components/providers/AuthProvider'
import { initializeApp } from 'firebase/app'

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

const firebaseConfig = {
  apiKey: process.env.REACT_APP_API_KEY,
  authDomain: process.env.REACT_APP_AUTH_DOMAIN,
  databaseURL: process.env.REACT_APP_DATABASE_URL,
  projectId: process.env.REACT_APP_PROJECT_ID,
  storageBucket: process.env.REACT_APP_STORAGE_BUCKET,
  messagingSenderId: process.env.REACT_APP_MESSAGING_SENDER_ID,
  appId: process.env.REACT_APP_APP_ID,
  measurementId: process.env.REACT_APP_MEASUREMENT_ID,
}

initializeApp(firebaseConfig)

export const App: React.VFC = () => {
  return (
    <>
      <ThemeProvider theme={theme}>
        <AuthProvider>
          <Box p={1}>
            <Router>
              <PageHeader />
              <Grid
                container
                direction="row"
                justifyContent="flex-start"
                alignItems="flex-start"
              >
                <Grid item xs={12}>
                  <Switch>
                    <Route path="/mypage">
                      <MyPage />
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
                </Grid>
              </Grid>
            </Router>
          </Box>
        </AuthProvider>
      </ThemeProvider>
    </>
  )
}
