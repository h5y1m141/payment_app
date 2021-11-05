import { initializeApp } from 'firebase/app'
import {
  EmailAuthProvider,
  getAuth,
  signInWithEmailAndPassword,
} from 'firebase/auth'

const firebaseConfig = {
  apiKey: process.env.FIREBASE_API_KEY,
  authDomain: process.env.FIREBASE_AUTH_DOMAIN,
  databaseURL: process.env.FIREBASE_DATABASE_URL,
  projectId: process.env.FIREBASE_PROJECT_ID,
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID,
  appId: process.env.FIREBASE_APP_ID,
  measurementId: process.env.FIREBASE_MEASUREMENT_ID,
}


initializeApp(firebaseConfig)

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
