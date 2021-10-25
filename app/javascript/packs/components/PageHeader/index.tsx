import React, { useCallback, useEffect, useState } from 'react'
import { Grid, Button } from '@material-ui/core'
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
      <Grid
        container
        direction="row"
        justifyContent="flex-end"
        alignItems="flex-start"
      >
        <Grid item xs={12}>
          {isLoggedIn ? (
            <Button
              variant="contained"
              color="primary"
              onClick={onClickSignOut}
            >
              ログアウト
            </Button>
          ) : null}
        </Grid>
      </Grid>
    </>
  )
}
