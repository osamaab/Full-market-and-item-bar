//
//  CLComponentGroupIdentifier.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

enum CLComponentGroupIdentifier: String, Hashable, CaseIterable {
    case buttons
    case cells
    case headersAndFooters
    case general
    case textFields
    case pickers
}

extension CLComponentGroupIdentifier: CLItem {
    var id: String {
        rawValue
    }
    
    var name: String {
        switch self {
        case .buttons:
            return "Buttons"
        case .cells:
            return "Common Cells"
        case .headersAndFooters:
            return "Headers and Footers"
        case .general:
            return "General"
        case .textFields:
            return "Text Fields"
        case .pickers:
            return "Pickers"
        }
    }
}
