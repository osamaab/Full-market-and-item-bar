//
//  NewItemInput.swift
//  talabyeh
//
//  Created by Hussein Work on 18/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct NewProductQuantityInput: Codable {
    let userItemId: Int
    let quantity: Int
    let productionDate: String
    let expirationDate: String

    enum CodingKeys: String, CodingKey {
        case userItemId = "user_item_id"
        case quantity = "quantity"
        case productionDate = "production_date"
        case expirationDate = "expiration_date"
    }
}

struct NewItemInput: Codable {
    let itemId: Int
    let price: Double
    let quantity: Int
    let description: String
    let moreDetails: String
    let unitId: Int
    let productionDate: String
    let expirationDate: String
    var imagesB64: [String]

    enum CodingKeys: String, CodingKey {
        case itemId = "item_id"
        case price = "price"
        case quantity = "quantity"
        case description = "description"
        case moreDetails = "more_details"
        case unitId = "unit_id"
        case productionDate = "production_date"
        case expirationDate = "expiration_date"
        case imagesB64 = "images_b64"
    }
}
