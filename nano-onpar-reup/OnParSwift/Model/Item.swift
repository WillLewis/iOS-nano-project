//
//  Item.swift
//  OnParSwift
//
//  Created by William Lewis on 4/18/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import Foundation
import Firebase

struct Item {
    var id: String
    var category: String
    var brand: String
    var name: String
    var model: String
    var box: String
    var papers: String
    var serialStart: String
    var braceletCode: String
    var endLinkCode: String
    var linkCount: String
    var price: Double
    var itemDescription: String
    var feedImageUrl: String
    var topImageUrl1: String
    var topImageUrl2: String
    var topImageUrl3: String
    var topImageUrl4: String
    var topImageUrl5: String
    var highlightImageUrl1: String
    var highlightImageUrl2: String
    var highlightImageUrl3: String
    var highlightImageUrl4: String
    var highlightImageUrl5: String
    var inspectionTimeDate: String
    var inspectionDay: String
    var available: Bool
    var stock: Int
    var timeStamp: Timestamp

    
    //initialize item here
    init(firestoreDoc: [String: Any]) {
        self.id = firestoreDoc["id"] as? String ?? ""
        self.category = firestoreDoc["category"] as? String ?? ""
        self.brand = firestoreDoc["brand"] as? String ?? ""
        self.name = firestoreDoc["name"] as? String ?? ""
        self.model = firestoreDoc["model"] as? String ?? ""
        self.box = firestoreDoc["box"] as? String ?? ""
        self.papers = firestoreDoc["papers"] as? String ?? ""
        self.serialStart = firestoreDoc["serialStart"] as? String ?? ""
        self.braceletCode = firestoreDoc["braceletCode"] as? String ?? ""
        self.endLinkCode = firestoreDoc["endLinkCode"] as? String ?? ""
        self.linkCount = firestoreDoc["linkCount"] as? String ?? ""
        self.price = firestoreDoc["price"] as? Double ?? 0.0
        self.itemDescription = firestoreDoc["itemDescription"] as? String ?? ""
        self.feedImageUrl = firestoreDoc["feedImageUrl"] as? String ?? ""
        self.topImageUrl1 = firestoreDoc["topImageUrl1"] as? String ?? ""
        self.topImageUrl2 = firestoreDoc["topImageUrl2"] as? String ?? ""
        self.topImageUrl3 = firestoreDoc["topImageUrl3"] as? String ?? ""
        self.topImageUrl4 = firestoreDoc["topImageUrl4"] as? String ?? ""
        self.topImageUrl5 = firestoreDoc["topImageUrl5"] as? String ?? ""
        self.highlightImageUrl1 = firestoreDoc["highlightImageUrl1"] as? String ?? ""
        self.highlightImageUrl2 = firestoreDoc["highlightImageUrl2"] as? String ?? ""
        self.highlightImageUrl3 = firestoreDoc["highlightImageUrl3"] as? String ?? ""
        self.highlightImageUrl4 = firestoreDoc["highlightImageUrl4"] as? String ?? ""
        self.highlightImageUrl5 = firestoreDoc["highlightImageUrl5"] as? String ?? ""
        self.inspectionTimeDate = firestoreDoc["inspectionTimeDate"] as? String ?? ""
        self.inspectionDay = firestoreDoc["inspectionDay"] as? String ?? "UPCOMING"
        self.available = firestoreDoc["available"] as? Bool ?? false
        self.stock = firestoreDoc["stock"] as? Int ?? 0
        self.timeStamp = firestoreDoc["timeStamp"] as? Timestamp ?? Timestamp()
    }
    
    static func modelToFSDoc(item: Item) -> [String: Any] {
        
        let firestoreDoc : [String: Any] = [
            
            "id" : item.id,
            "category" : item.category,
            "brand" : item.brand,
            "name" : item.name,
            "model" : item.model,
            "box" : item.box,
            "papers" : item.papers,
            "serialStart" : item.serialStart,
            "braceletCode" : item.braceletCode,
            "endLinkCode" : item.endLinkCode,
            "linkcount" : item.linkCount,
            "price" : item.price,
            "itemDescription" : item.itemDescription,
            "feedImageUrl" : item.feedImageUrl,
            "topImageUrl1" : item.topImageUrl1,
            "topImageUrl2" : item.topImageUrl2,
            "topImageUrl3" : item.topImageUrl3,
            "topImageUrl4" : item.topImageUrl4,
            "topImageUrl5" : item.topImageUrl5,
            "highlightImageUrl1" : item.highlightImageUrl1,
            "highlightImageUrl2" : item.highlightImageUrl2,
            "highlightImageUrl3" : item.highlightImageUrl3,
            "highlightImageUrl4" : item.highlightImageUrl4,
            "highlightImageUrl5" : item.highlightImageUrl5,
            "inspectionTimeDate" : item.inspectionTimeDate,
            "inspectionDaY" : item.inspectionDay,
            "available" : item.available,
            "stock" : item.stock,
            "timeStamp" : item.timeStamp
        ]
        
        return firestoreDoc
    }
}

extension Item : Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
