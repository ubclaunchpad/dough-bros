var admin = require("firebase-admin");

import serviceAccount from "./serviceAccountKey.json";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://dough-bros-2020.firebaseio.com"
});

export function sendMessageToUser(deviceID: any, message: any) {
    console.log("sending!");

    var messageBody = {
        notification: {
            title: message,
            body: ''
        },
    }
    
    admin.messaging().sendToDevice(deviceID, messageBody).then(() => {
        console.log("Success");
    }).catch((e: any) => {
        console.log("Error")
        console.log(e);
    })
}