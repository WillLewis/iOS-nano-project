**ACCESS**<br/>
Add the Firebase API key to the Google plist in order to connect the app to its firebase server. You may also need to run a pod install. Please send any questions to willxemail@gmail.com.

**INSTRUCTIONS**<br/>
1) Add API Key provided to the row labeled "API_KEY" in Google-Service-Into.plist 
2) Register with an email and password
3) Allow text messages when prompted
4) Tap Notify Me in the Upcoming View Controller to get a text indicating youve registered for push notifications 
5) Tap any of the items to see detail view of item.

**FUNCTIONS**<br/>
The application allows users to view items that are made available for any given day of the week. Users can do one of three things -- i) sign up as a user with an email and password; ii) view details about any item, including photos, a text description and detail piece parts of the item; and ii) sign up for notifications about that item. 

**UI**<br/>
The apps main view places items in their appropriate section based on data stored about that item in Firebase Firestore. The detail view of any item combines horizontal and vertical collection views to display photos.

**BACKEND**<br/>
The Firebase API is used to register users, store user authentication info and handle future authentication. 

Photos of the item along with the items details and text are stored in firebase storage for fast upload. The urls of the item photos are stored in firebase firestore along with other details on that item.

When a user registers for notifications for an item, that item is added to firebase firestore as a notifying item from the client side. On the server side, cloud functions listen for any additions to that users notifying items list and when an item is added, send a push notification indicating that the registration for notifications for that item have been successful.

**NOTICE**<br/>
This is the alpha version of an app and there are several features being worked on that are not yet enabled.

**DEMO**<br/>
![Demo of app](REUP-App.gif)
