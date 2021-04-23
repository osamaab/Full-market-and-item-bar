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
    let totalQuantity: Int
    let username: String? = "__hussein"
    let description: String?
    let price: Double
        
    let unit: ProductUnit
    let item: ProductTemplate
    let images: [RemoteImage]
    let history: [ProductHistoryEntry]
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case totalQuantity = "item_total_quantity"
        case description
        case username
        case price
        case item
        case unit
        case images
        case history
    }
}

extension Product: Codable {
    
}


extension Double {
    var priceFormatted: String {
        "JD \(self)"
    }
}
