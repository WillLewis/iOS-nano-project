//
//  ProfileSections.swift
//  OnParSwift
//
//  Created by William Lewis on 4/13/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
    
}

enum ProfileSection: Int, CaseIterable, CustomStringConvertible {
    case linkedAccounts
    case settings
    
    var description: String {
        switch self {
        case .linkedAccounts: return "Linked Accounts"
        case .settings: return "Settings"
        }
    }
}

enum LinkedAccounts: Int, CaseIterable, SectionType {
    case bankAccount
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .bankAccount: return "Current Account"
        }
    }
}

enum Settings: Int, CaseIterable, SectionType {
    case notifications
    case email
    case name
    case phoneNumber
    case logOut
    
    var containsSwitch: Bool {
        switch self {
        case .notifications: return true
        case .email: return true
        case .name: return false
        case .phoneNumber: return false
        case .logOut: return false
        }
    }
    
    var description: String {
        switch self {
        case .notifications: return "Notifications"
        case .email: return "Email Communications"
        case .name: return "Name"
        case .phoneNumber: return "Phone Number"
        case .logOut: return "Sign Out"
        }
    }
}
