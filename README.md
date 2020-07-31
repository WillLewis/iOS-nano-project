ACCESS: Add the Firebase API key to the Google plist in order to connect the app to its firebase server. You may also need to run a pod install. Please send any questions to willxemail@gmail.com.

The application allows users to view items that are made available for any given day of the week. Users can do one of three things -- i) sign up as a user with an email and password; ii) view details about any item, including photos, a text description and detail piece parts of the item; and ii) sign up for notifications about that item. 

The Firebase API is used to register users, store user authentication info and handle future authentication. 

Photos of the item along with the items details and text are stored in firebase storage for fast upload. The urls of the item photos are stored in firebase firestore along with other details on that item.

When a user registers for notifications for an item, that item is added to firebase firestore as a notifying item from the client side. On the server side, cloud functions listen for any additions to that users notifying items list and when an item is added, send a push notification indicating that the registration for notifications for that item have been successful.

This is the alpha version of an app and there are several features being worked on that are not yet enabled.


