//
//  CLColorsSection.swift
//  talabyeh
//
//  Created by Hussein Work on 25/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct CLColorsSection: CLItemsSection, Hashable, Equatable {
    typealias ItemType = CLColorItem
    
    let id: String = UUID().uuidString
    
    let name: String
    
    var items: [CLColorItem] = []
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CLColorsSection, rhs: CLColorsSection) -> Bool {
        lhs.id == rhs.id
    }
}
