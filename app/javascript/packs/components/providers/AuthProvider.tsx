import React, { createContext, useState, useEffect } from 'react'
import { getAuth, onAuthStateChanged } from 'firebase/auth'

type AuthState = {
  uid: string
}

export const initialAuthState: AuthState = {
  uid: '',
}

export const AuthStateContext = createContext<
  [AuthState, (currentCustomer: AuthState) => void]
>([initialAuthState, () => {}])

export const AuthProvider: React.FC = ({ children }) => {
  const [currentCustomer, setCurrentCustomer] =
    useState<AuthState>(initialAuthState)

  useEffect(() => {
    const auth = getAuth()
    onAuthStateChanged(auth, (user) => {
      if (user) {
        setCurrentCustomer({
          uid: user.uid,
        })
      }
    })
  }, [])

  return (
    <>
      <AuthStateContext.Provider value={[currentCustomer, setCurrentCustomer]}>
        <div>{children}</div>
      </AuthStateContext.Provider>
    </>
  )
}
