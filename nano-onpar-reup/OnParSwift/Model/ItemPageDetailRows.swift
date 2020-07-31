//
//  ItemDetailSectionRows.swift
//  OnParSwift
//
//  Created by William Lewis on 5/18/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//


enum DetailRow: Int, CaseIterable, CustomStringConvertible {
    case hasBox
    case hasPapers
    case serial
    case bracelet
    case endLink
    case numOflinks
    
    var description: String {
        switch self {
        case .hasBox: return "BOX"
        case .hasPapers: return "PAPERS"
        case .serial: return "SERIAL START"
        case .bracelet: return "BRACELET CODE"
        case .endLink: return "END LINK CODE"
        case .numOflinks: return "LINK COUNT"
        }
    }
}
