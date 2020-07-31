//
//  Category.swift
//  OnParSwift
//
//  Created by William Lewis on 4/21/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import Foundation
import Firebase

struct Category {
    var name: String
    var id: String
    var imgUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
    
    //maybe not necessary
    init(
        name: String,
        id: String,
        imgUrl: String,
        isActive: Bool = true,
        timeStamp: Timestamp) {

        self.name = name
        self.id = id
        self.imgUrl = imgUrl
        self.isActive = isActive
        self.timeStamp = timeStamp
    }
    
    //initialize category here
    init(firestoreDoc: [String: Any]) {
        self.name = firestoreDoc["name"] as? String ?? ""
        self.id = firestoreDoc["id"] as? String ?? ""
        self.imgUrl = firestoreDoc["imgUrl"] as? String ?? ""
        self.isActive = firestoreDoc["isActive"] as? Bool ?? true
        self.timeStamp = firestoreDoc["timeStamp"] as? Timestamp ?? Timestamp()
    }
    
    static func modelToFSDoc(category: Category) -> [String: Any] {
        let firestoreDoc : [String: Any] = [
            "name" : category.name,
            "id" : category.id,
            "imgUrl" : category.imgUrl,
            "isActive" : category.isActive,
            "timeStamp" : category.timeStamp
        ]
        
        return firestoreDoc
    }
}
