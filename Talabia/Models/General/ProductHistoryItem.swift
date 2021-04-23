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
    let expirationDateString: String
    let productionDateString: String
    let entryDateString: String
    let userItemId: Int

    enum CodingKeys: String, CodingKey {
        case quantity = "quantity"
        case id = "id"
        case expirationDateString = "expiration_date_string"
        case productionDateString = "production_date_string"
        case entryDateString = "entry_date_string"
        case userItemId = "user_item_id"
    }
}
