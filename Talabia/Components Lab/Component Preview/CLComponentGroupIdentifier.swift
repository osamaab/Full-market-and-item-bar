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
        rawValue.camelCaseToWords().capitalizingFirstLetter()
    }
}
