//
//  Product.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct ProductTemplate: Equatable, Hashable {
    let id: Int
    let name: String
    let barcode: String
    let subcategoryID: Int
//    let unit: ProductUnit
//    let category: SubCategory

    enum CodingKeys: String, CodingKey {
        case id
        case name
//        case unit
        case barcode
        case subcategoryID = "subcategory_id"
//        case category = "subcategory"
    }
}

extension ProductTemplate: Codable {
    
}
