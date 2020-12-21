//
//  CLComponentsSection.swift
//  talabyeh
//
//  Created by Hussein Work on 19/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct CLComponentsSection: CLItemsSection, Hashable, Equatable {
   typealias ItemType = CLAnyComponentItem
    
    
    let id: String = UUID().uuidString
    
    let name: String
    
    var items: [CLAnyComponentItem] = []
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CLComponentsSection, rhs: CLComponentsSection) -> Bool {
        lhs.id == rhs.id
    }
}
