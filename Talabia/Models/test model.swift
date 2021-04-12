//
//  test model.swift
//  talabyeh
//
//  Created by Osama Abu hdba on 31/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation


// MARK: - Results
struct MarketModel: Codable {
    let bannerURL: String
    let companies: [Companay]
    let hotSellingItems: [HotSellingItem]
    let subcategories: [Subcategory]

    enum CodingKeys: String, CodingKey {
        case bannerURL = "banner_url"
        case companies
        case hotSellingItems = "hot_selling_items"
        case subcategories
    }
}

// MARK: - Companay
struct Companay: Codable {
    let deliveryFees: Int
    let isFav: Bool
    let id: Int
    let title, email, nationalNumber, telephone: String
    let logoPath: String
    let lat, lng, fax, ext: String
    let password: JSONNull?
    let website: String
    let username: JSONNull?
    let additionalInfo: AdditionalInfo
    let registeredDate: String
    let user: JSONNull?

    enum CodingKeys: String, CodingKey {
        case deliveryFees = "delivery_fees"
        case isFav = "is_fav"
        case id, title, email
        case nationalNumber = "national_number"
        case telephone
        case logoPath = "logo_path"
        case lat, lng, fax, ext, password, website, username
        case additionalInfo = "additional_info"
        case registeredDate = "registered_date"
        case user
    }
}

// MARK: - AdditionalInfo
struct AdditionalInfo: Codable {
    let bannerPath: String
    let summary, vision, history, more: String
    let certificatePath: String

    enum CodingKeys: String, CodingKey {
        case bannerPath = "banner_path"
        case summary, vision, history, more
        case certificatePath = "certificate_path"
    }
}

// MARK: - HotSellingItem
struct HotSellingItem: Codable {
    let id, itemID: Int
    let hotSellingItemDescription, moreDetails: String
    let unitID: Int
    let isActive: Bool
    let price: Double
    let unit: Unit
    let item: Item
    let images: [Image]
    let history: [History]
    let itemTotalQuantity: Int

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case hotSellingItemDescription = "description"
        case moreDetails = "more_details"
        case unitID = "unit_id"
        case isActive = "is_active"
        case price, unit, item, images, history
        case itemTotalQuantity = "item_total_quantity"
    }
}

// MARK: - History
struct History: Codable {
    let id, userItemID, quantity: Int
    let productionDateString, expirationDateString, entryDateString: String

    enum CodingKeys: String, CodingKey {
        case id
        case userItemID = "user_item_id"
        case quantity
        case productionDateString = "production_date_string"
        case expirationDateString = "expiration_date_string"
        case entryDateString = "entry_date_string"
    }
}

// MARK: - Image
struct Image: Codable {
    let id, userItemID: Int
    let url: String
    let path: String

    enum CodingKeys: String, CodingKey {
        case id
        case userItemID = "user_item_id"
        case url, path
    }
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let name: String
    let unitID, subcategoryID: Int
    let barcode: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case unitID = "unit_id"
        case subcategoryID = "subcategory_id"
        case barcode
    }
}

// MARK: - Unit
struct Unit: Codable {
    let id: Int
    let title: String
}

// MARK: - Subcategory
struct Subcategory: Codable {
    let id, categoryID: Int
    let title, logo: String
    let logoPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title, logo
        case logoPath = "logo_path"
    }
}

// MARK: - Status
struct Status: Codable {
    let message: String
    let code: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
