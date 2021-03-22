var admin = require("firebase-admin");

import serviceAccount from "./serviceAccountKey.json";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://dough-bros-2020.firebaseio.com"
});

export function sendMessageToUser(deviceID: any, message: any) {
    console.log('sending!');

    var messageBody = {
        notification: {
            title: message,
            body: ''
        },
    }
    
    try {
        admin.messaging().sendToDevice(deviceID, messageBody);
    } catch (err) {
        console.log('Messaging Error:');
        console.log(err);
    }
}