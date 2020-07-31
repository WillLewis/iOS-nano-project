//
//  ItemMessage.swift
//  OnParSwift
//
//  Created by William Lewis on 4/23/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import Firebase
import FirebaseUI
import FirebaseMessaging


struct ItemMessage {
    let text, uid, name, profileImageUrl: String
    let timestamp: Timestamp
    
    
    init(dictionary: [String: Any]) {
           self.text = dictionary["text"] as? String ?? ""
           self.uid = dictionary["uid"] as? String ?? ""
           self.name = dictionary["name"] as? String ?? ""
           self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
           
           self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
