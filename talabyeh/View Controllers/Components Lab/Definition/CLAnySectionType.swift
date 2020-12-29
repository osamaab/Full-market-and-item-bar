//
//  CLAnySectionType.swift
//  talabyeh
//
//  Created by Hussein Work on 19/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct CLAnySectionType: CLItemsSection, Equatable, Hashable {
    typealias ItemType = CLAnyItem
    
    let id: String
    
    let name: String
    
    let items: [CLAnyItem]
    
    init(id: String = UUID().uuidString, name: String, items: [CLAnyItem]){
        self.name = name
        self.id = id
        self.items = items
    }
    
    init<S: CLItemsSection>(section: S){
        self.id = section.id
        self.name = section.name
        self.items = section.items.map(CLAnyItem.init)
    }
}
