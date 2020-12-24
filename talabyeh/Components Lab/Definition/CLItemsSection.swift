//
//  CLItemsSection.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

protocol CLItemsSection: CLItem {
    associatedtype ItemType: CLItem
    
    var id: String { get }
    var name: String { get }
    
    var items: [ItemType] { get }
}

