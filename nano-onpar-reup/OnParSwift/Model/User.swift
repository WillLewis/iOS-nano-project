//
//  User.swift
//  OnParSwift
//
//  Created by William Lewis on 4/13/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import Foundation

struct User {

    let uid: String
    let username: String
    let email: String
    let profileImageUrl: String

    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
