// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth, onAuthStateChanged } from "firebase/auth";
import { getFirestore, collection, getDocs } from "firebase/firestore";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCB6rHhlymGqojj1dRh5TOpmG_ajwQJkPg",
  authDomain: "addm4riota-lp.firebaseapp.com",
  projectId: "addm4riota-lp",
  storageBucket: "addm4riota-lp.appspot.com",
  messagingSenderId: "926007422054",
  appId: "1:926007422054:web:6fd23c70af568fb3c7d1a7",
  measurementId: "G-MMB62FK5PW"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);
const analytics = getAnalytics(app);

//detect auth state
onAuthStateChanged(auth, user => {
    if (user != null) {
        console.log('Logged in!');
    } else {
        console.log('no user')
    }
})