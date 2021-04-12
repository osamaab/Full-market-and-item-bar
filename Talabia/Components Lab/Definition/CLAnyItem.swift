//
//  CLAnyItem.swift
//  talabyeh
//
//  Created by Hussein Work on 19/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct CLAnyItem: CLItem, Equatable, Hashable {
    static func == (lhs: CLAnyItem, rhs: CLAnyItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let name: String
    
    let underlyingItem: Any
    
    init<T: CLItem>(item: T){
        self.id = item.id
        self.name = item.name
        self.underlyingItem = item
    }
    
    init(item: CLItem){
        self.id = item.id
        self.name = item.name
        self.underlyingItem = item
    }
    
    init<T: CLItem>(name: String, underlyingItem: T){
        self.name = name
        self.id = UUID().uuidString
        self.underlyingItem = underlyingItem
    }
}
