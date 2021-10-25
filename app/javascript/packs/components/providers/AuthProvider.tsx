import React, { createContext, useContext, useState, useEffect } from 'react'
import { getAuth, onAuthStateChanged } from 'firebase/auth'

type AuthState = {
  uid: string
  idToken: string
}

export const initialAuthState: AuthState = {
  uid: '',
  idToken: '',
}

export const AuthStateContext = createContext<
  [AuthState, (currentCustomer: AuthState) => void]
>([initialAuthState, () => {}])

export const useCurrentCustomer = () => useContext(AuthStateContext)

export const AuthProvider: React.FC = ({ children }) => {
  const [currentCustomer, setCurrentCustomer] =
    useState<AuthState>(initialAuthState)

  useEffect(() => {
    const auth = getAuth()
    onAuthStateChanged(auth, async (user) => {
      if (user) {
        const idToken = await user.getIdToken()
        setCurrentCustomer({
          uid: user.uid,
          idToken,
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
