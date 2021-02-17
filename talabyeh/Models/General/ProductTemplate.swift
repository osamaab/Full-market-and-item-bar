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
    let unitID: Int
    let unit: ProductUnit
    let categoryID: Int
    let barcode: String
    let category: MainCategory

    enum CodingKeys: String, CodingKey {
        case id, name
        case unitID = "unit_id"
        case unit
        case categoryID = "category_id"
        case barcode, category
    }
}

extension ProductTemplate {
    static func sample(title: String) -> ProductTemplate {
        ProductTemplate(id: 1,
                name: title,
                unitID: 1,
                unit: .init(id: 1, title: "KG"),
                categoryID: 1,
                barcode: "",
                category: .init(id: 1, title: "CAT", logo: nil, subcategories: []))
    }
}

extension ProductTemplate: Codable {
    
}
