import React, { useCallback, useEffect, useState } from 'react'
import { Grid, Box, Button, makeStyles } from '@material-ui/core'
import { Link, useLocation } from 'react-router-dom'
import { useCurrentCustomer } from '../../components/providers/AuthProvider'
import { getAuth } from 'firebase/auth'

export const PageHeader: React.VFC = () => {
  const classes = useStyles({})
  const [currentCustomer, setCurrentCustomer] = useCurrentCustomer()
  const [isLoggedIn, setIsLoggedIn] = useState<boolean>(false)
  const location = useLocation()

  const onClickSignOut = useCallback(async () => {
    const auth = getAuth()
    await auth.signOut()
    setCurrentCustomer({
      uid: '',
      idToken: '',
    })
  }, [])

  useEffect(() => {
    currentCustomer.uid ? setIsLoggedIn(true) : setIsLoggedIn(false)
  }, [currentCustomer])

  return (
    <>
      {isLoggedIn ? (
        <Grid
          container
          direction="row"
          justifyContent="flex-end"
          alignItems="flex-start"
        >
          <Grid item>
            <Button
              variant="contained"
              color="primary"
              onClick={onClickSignOut}
            >
              ログアウト
            </Button>
          </Grid>
          <Grid item>
            <Box p={1} />
          </Grid>
          <Grid item>
            <Link
              className={classes.link}
              to={location.pathname === '/orders' ? '/products' : '/orders'}
            >
              <Button variant="contained" color="primary">
                {location.pathname === '/orders' ? '商品一覧' : '注文一覧'}
              </Button>
            </Link>
          </Grid>
        </Grid>
      ) : null}
    </>
  )
}
const useStyles = makeStyles(() => ({
  link: {
    textDecoration: 'none',
  },
}))
