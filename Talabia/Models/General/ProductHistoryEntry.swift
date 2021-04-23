//
//  ProductHistoryItem.swift
//  talabyeh
//
//  Created by Hussein Work on 18/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation


struct ProductHistoryEntry: Codable {
    let quantity: Int
    let id: Int
    let expirationDate: String
    let productionDate: String
    let entryDate: String
    let productID: Int

    enum CodingKeys: String, CodingKey {
        case quantity = "quantity"
        case id = "id"
        case expirationDate = "expiration_date_string"
        case productionDate = "production_date_string"
        case entryDate = "entry_date_string"
        case productID = "user_item_id"
    }
}
