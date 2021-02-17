//
//  Product.swift
//  talabyeh
//
//  Created by Hussein Work on 16/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct Product: Equatable, Hashable {
    
    let id: Int
    let quantity: Int
    let username: String
    let itemID: Int
    
    let item: ProductTemplate
    let category: SubCategory
    
    enum CodingKeys: String, CodingKey {
        case id
        case quantity
        case username
        case itemID = "item_id"
        case item
        case category
    }
}

extension Product: Codable {
    
}
