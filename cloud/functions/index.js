const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// Since this code will be running in the Cloud Functions environment
// we call initialize Firestore and Realtime Database without any arguments because it
// detects authentication from the environment.
const firestore = admin.firestore();
const realdb = admin.database();

exports.helloWorld = functions.https.onRequest((request, response) => {
 response.send("Hello from Firebase!");

});

// //listen for notificationButton taps and trigger push notification
exports.notificationCreated = functions.firestore.document('/users/{userId}/notifyingItems/{docId}').onCreate(async (snap, context) => {
  console.log("LOGGER - TRYING TO SEND PUSH NOTIFICATIONS")

  //create reference to user id and doc from context
  const user = context.params.userId;
  const docId = context.params.docId;
  console.log('User: ' + user + ' just followed : ' + docId);

  return admin.firestore().doc(`/items/${docId}`).get().then((snap, context) => {
    //get brand, name and model of the followed item
    const brand = snap.data().brand;
    const name = snap.data().name;
    const model = snap.data().model;
    const fullName = brand + ' ' + name + ' Model: ' + model;
    console.log(' this item was just followed : ' + fullName);

    //use the userId in firestore to get the fcmToken from the user in Realtime Database
    return admin.database().ref(`/users/${user}/fcmToken`).once('value').then((snap, context) => {
      const token = snap.val();
      console.log(user + ' fcmToken: ' + token);

      const payload = {
        notification: {
          title: 'You are now following a ...',
          body: fullName,
          //icon: newValue.
        }
      };

      //send message to user who just followed item
      return admin.messaging().sendToDevice(token, payload);
    });
  })
})
