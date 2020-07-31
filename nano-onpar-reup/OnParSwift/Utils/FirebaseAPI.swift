//
//  FirebaseAPI.swift
//  OnParSwift
//  Denormalization done to make querying easier: Create a sub collection called notifying items to the user object w copies of all the notifying tems for that user. Add a copy of each item document for each item notifications requested and remove it when user removes notifications.
//
//  Created by William Lewis on 4/14/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//


import Firebase
import FirebaseStorage
import FirebaseUI

let FBAPI = _FBAPI()

final class _FBAPI {
    var fbUser: User?
    var fsUser = FireStoreUser()
    let db = Firestore.firestore()
    var notifyingItems = [Item]()
    var userListener : ListenerRegistration? = nil
    var notificationsListener : ListenerRegistration? = nil
    
    var isGuest: Bool {
        guard let authUser = Auth.auth().currentUser else {return true}
        if authUser.isAnonymous{
            return true
        } else {
            return false
        }
    }
    
    //MARK: TODO -- For a future viewcontroller that shows the items user is getting notifications on
    func fetchUserNotifications() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userRef = db.collection("users").document(uid)
        userListener = userRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let data = snap?.data() else { return }
            self.fsUser = FireStoreUser.init(firestoreDoc: data)
        })
        
        let notifyingItemsRef = userRef.collection("notifyingItems")
        notificationsListener = notifyingItemsRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
                let notifyingItem = Item.init(firestoreDoc: document.data())
                self.notifyingItems.append(notifyingItem)
            })
        })
    }
    
    func notifyButtonPressed(item: Item){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let notifyingItemsRef = Firestore.firestore().collection("users").document(uid).collection("notifyingItems")
        
        if notifyingItems.contains(item) {
            notifyingItems.removeAll{ $0 == item }
            notifyingItemsRef.document(item.id).delete()
            
        } else {
            notifyingItems.append(item)
            let firestoreDoc = Item.modelToFSDoc(item: item)
            notifyingItemsRef.document(item.id).setData(firestoreDoc)
        }
    }
}

extension Database {
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            let user = User(uid: uid, dictionary: userDictionary)
            completion(user)
            
        }) { (err) in
            print("Failed to fetch user for posts:", err)
        }
    }
}

extension Firestore {
    var items: Query {
        return collection("items").order(by: "timeStamp", descending: true)
    }
}

extension Auth {
    func handleFireAuthError(error: Error, vc: UIViewController) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account. Pick another email!"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password or email is incorrect."
            
        default:
            return "Sorry, something went wrong."
        }
    }
}
