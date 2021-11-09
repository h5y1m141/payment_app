import { initializeApp } from 'firebase/app'
import {
  EmailAuthProvider,
  getAuth,
  signInWithEmailAndPassword,
} from 'firebase/auth'

window.addEventListener('DOMContentLoaded', (event) => {
  const form = document.getElementById('loginForm')
  const {
    apiKey,
    authDomain,
    databaseURL,
    projectId,
    storageBucket,
    messagingSenderId,
    appId,
    measurementId,
  } = form.dataset
  const firebaseConfig = {
    apiKey,
    authDomain,
    databaseURL,
    projectId,
    storageBucket,
    messagingSenderId,
    appId,
    measurementId,
  }

  initializeApp(firebaseConfig)
})

const firebaseLogin = async (email, password) => {
  const auth = getAuth()
  const userCredential = await signInWithEmailAndPassword(auth, email, password)
  const res = await railsLogin(userCredential)
  console.log(res)
}

const railsLogin = async (userCredential) => {
  if (userCredential) {
    const user = userCredential.user
    const idToken = await user.getIdToken()
    const url = '/admin/login'
    const data = {
      id_token: idToken,
    }
    const params = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    }
    const response = await fetch(url, params)
    if (response) {
      document.location.href = '/admin/products'
    }
  }
}

document.getElementById('loggedInButton').addEventListener('click', () => {
  const inputs = document.getElementById('loginForm').elements
  const email = inputs['email'].value
  const password = inputs['password'].value
  firebaseLogin(email, password)
})
