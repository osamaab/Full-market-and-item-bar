//
//  CLScreensSection.swift
//  talabyeh
//
//  Created by Hussein Work on 19/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation


struct CLScreensSection: CLItemsSection, Hashable, Equatable {
    typealias ItemType = CLScreenItem
    
    let id: String = UUID().uuidString
    
    let name: String
    
    var items: [CLScreenItem] = []
}
