import React, { useCallback, useEffect, useState } from 'react'
import { Grid, Box, Button } from '@material-ui/core'
import { Link } from 'react-router-dom'
import { useCurrentCustomer } from '../../components/providers/AuthProvider'
import { getAuth } from 'firebase/auth'

export const PageHeader: React.VFC = () => {
  const [currentCustomer, setCurrentCustomer] = useCurrentCustomer()
  const [isLoggedIn, setIsLoggedIn] = useState<boolean>(false)

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
            <Link to="/orders">
              <Button variant="contained" color="primary">
                注文を確認する
              </Button>
            </Link>
          </Grid>
        </Grid>
      ) : null}
    </>
  )
}
