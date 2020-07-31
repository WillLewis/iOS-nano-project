//
//  FireUser.swift
//  OnParSwift
//  Purpose: Need to a firestore user for every authenticated user 
//
//  Created by William Lewis on 4/20/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import Foundation

struct FireStoreUser {
    var id: String
    var stripeId: String
    
    //maybe not necessary
    init(id: String = "",
         stripeId: String = "") {
        
        self.id = id
        self.stripeId = stripeId
    }
    
    //initialize firestore user here
    init(firestoreDoc: [String: Any]) {
        self.id = firestoreDoc["id"] as? String ?? ""
        self.stripeId = firestoreDoc["stripeId"] as? String ?? ""
    }
    
    static func modelToFSDoc(user: FireStoreUser) -> [String: Any] {
        
        let firestoreDoc : [String: Any] = [
            "id" : user.id,
            "stripeId" : user.stripeId
        ]
        
        return firestoreDoc
    }
}
