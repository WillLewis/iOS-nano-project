//
//  UpcomingSections.swift
//  OnParSwift
//
//  Created by William Lewis on 5/26/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import Foundation
import Firebase

//Used for fetching items by day from firebase
struct InspectionDay {
    var day: String
    var id: String
    
    init(data: [String: Any]) {
        self.day = data["day"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
    }
    
    static func modelToData(inspectionDay: InspectionDay) -> [String: Any] {
        let data : [String: Any] = [
            "day" : inspectionDay.day,
            "id" : inspectionDay.id,
        ]
        
        return data
    }
}

protocol InspectionDayType: CustomStringConvertible {
}

//Used for the section headers in UpcomingViewController
enum InspectionDaySection: Int, CaseIterable, CustomStringConvertible, InspectionDayType {
    
    case today
    case tomorrow
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    case upcoming
    
    var description: String {
        switch self {
        case .today: return "TODAY"
        case .tomorrow: return "TOMORROW"
        case .monday: return "MONDAY"
        case .tuesday: return "TUESDAY"
        case .wednesday: return "WEDNESDAY"
        case .thursday: return "THURSDAY"
        case .friday: return "FRIDAY"
        case .saturday: return "SATURDAY"
        case .sunday: return "SUNDAY"
        case .upcoming: return "UPCOMING"
        }
    }
}
