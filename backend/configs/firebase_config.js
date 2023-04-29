// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
var admin = require("firebase-admin");
var serviceAccount = require("../hello-768dc-firebase-adminsdk-aqlg3-406697abb4.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyB3dSsLtaWHC-SF7xQA7jigf76TJN5MLKM",
  authDomain: "hello-768dc.firebaseapp.com",
  projectId: "hello-768dc",
  storageBucket: "hello-768dc.appspot.com",
  messagingSenderId: "837247294878",
  appId: "1:837247294878:web:f9c3119ce0210b39d5ca8f"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);