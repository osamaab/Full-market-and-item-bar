//
//  Product.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct Product: Equatable, Hashable {
    let id: Int
    let name: String
    let unitID: Int
    let unit: Unit
    let categoryID: Int
    let barcode: String
    let category: Category

    enum CodingKeys: String, CodingKey {
        case id, name
        case unitID = "unit_id"
        case unit
        case categoryID = "category_id"
        case barcode, category
    }
}

extension Product: Codable {
    
}
