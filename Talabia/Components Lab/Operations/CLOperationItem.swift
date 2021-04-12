//
//  CLOperationItem.swift
//  talabyeh
//
//  Created by Hussein Work on 26/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct CLOperationItem: Equatable, Hashable {
    static func == (lhs: CLOperationItem, rhs: CLOperationItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let identifier: CLOperationIdentifier
    let name: String
    
    var action: ActionBlock
}

extension CLOperationItem: CLItem {
    var id: String {
        identifier.rawValue
    }
}

//MARK: Common Operations


extension CLOperationItem {
    static func listCompanies() -> CLOperationItem {
        CLOperationItem(identifier: .listCompanies, name: "List Companies ( Debug )") {
            
        }
    }
}
