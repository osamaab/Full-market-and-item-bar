//
//  CLComponentsSection.swift
//  talabyeh
//
//  Created by Hussein Work on 19/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct CLComponentsSection: CLItemsSection, Hashable, Equatable {
    typealias ItemType = CLComponentItem
    
    var group: CLComponentGroupIdentifier
    var items: [CLComponentItem]
    
    var id: String {
        group.id
    }
    
    var name: String {
        group.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CLComponentsSection, rhs: CLComponentsSection) -> Bool {
        lhs.id == rhs.id
    }
}
