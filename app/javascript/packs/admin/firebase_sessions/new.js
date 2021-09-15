import firebase from 'firebase/app';
import * as firebaseui from 'firebaseui';
import 'firebaseui/dist/firebaseui.css'

const firebaseConfig = {
  apiKey: "AIzaSyBuvv2DVTNCfNMUdWSusqL4cA2VQm8GmD8",
  authDomain: "finalchainproto.firebaseapp.com",
  databaseURL: "https://finalchainproto.firebaseio.com",
  projectId: "finalchainproto",
  storageBucket: "finalchainproto.appspot.com",
  messagingSenderId: "1095795722258",
  appId: "1:1095795722258:web:91f25723862bf5370530cb",
  measurementId: "G-6PGLLTGH8S"
}

firebase.initializeApp(firebaseConfig)

const getCookie = (name) => {
  const value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
  return value ? value[2] : null;
}

const firebaseLogin = () => {  
  const ui = new firebaseui.auth.AuthUI(firebase.auth());
  const uiConfig = {
    callbacks: {
      signInSuccessWithAuthResult: (authResult, redirectUrl) => {
        authResult.user.getIdToken(true)
          .then((idToken) => { 
            const csrfToken = getCookie('csrfToken')
            railsLogin(idToken, csrfToken)
          })
          .catch((error)  => { console.log(`Firebase getIdToken failed!: ${error.message}`) });
        return false;
      },
      uiShown: () => { document.getElementById('loader').style.display = 'none' }
    },
    signInFlow: 'redirect',
    signInOptions: [
      firebase.auth.EmailAuthProvider.PROVIDER_ID
    ],
  };
  ui.start('#firebaseui-auth-container', uiConfig);
}

const railsLogin = async (idToken, csrfToken) => {
  const url = "/admin/login"
  const response = await fetch(url, {
    method: 'POST',
    headers: {
      "Authorization": `Bearer ${idToken}`,
      "X-CSRF-TOKEN":  csrfToken
    }
  })
  if (response) {
    const result = response.json
    console.log(result)
  }

}

document.addEventListener('DOMContentLoaded', () => {
  console.log('start firebase');
  firebaseLogin();
});
