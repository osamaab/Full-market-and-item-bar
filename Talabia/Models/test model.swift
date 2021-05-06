//
//  test model.swift
//  talabyeh
//
//  Created by Osama Abu hdba on 31/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

// MARK: - FavouriteCompany
struct FavouriteCompanies: Codable, Equatable {
    static func == (lhs: FavouriteCompanies, rhs: FavouriteCompanies) -> Bool {
        lhs.id == rhs.id
    }
    
    let username: String
    let id: Int
    let company: FavCompany?
    let companyID: Int

    enum CodingKeys: String, CodingKey {
        case username = "username"
        case id = "id"
        case company = "company"
        case companyID = "company_id"
    }
}

// MARK: - Company
struct FavCompany: Codable {
    let id: Int
    let registeredDate: String
    let user: User
    let categories: [Category]
    let subcategories: [Subcategory]
    let additionalInfo: AdditionalInfo
    let commercialLicensePath: String
    let logoPath: String
    let title: String
    let lat: String
    let fax: String
    let password: JSONNull?
    let ext: String
    let username: String
    let lng: String
    let telephone: String
    let email: String
    let nationalNumber: String
    let website: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case registeredDate = "registered_date"
        case user = "user"
        case categories = "categories"
        case subcategories = "subcategories"
        case additionalInfo = "additional_info"
        case commercialLicensePath = "commercial_license_path"
        case logoPath = "logo_path"
        case title = "title"
        case lat = "lat"
        case fax = "fax"
        case password = "password"
        case ext = "ext"
        case username = "username"
        case lng = "lng"
        case telephone = "telephone"
        case email = "email"
        case nationalNumber = "national_number"
        case website = "website"
    }
}

// MARK: - AdditionalInfo
struct AdditionalInfo: Codable {
    let history: String
    let bannerPath: String
    let certificatePath: String
    let vision: String
    let more: String
    let summary: String

    enum CodingKeys: String, CodingKey {
        case history = "history"
        case bannerPath = "banner_path"
        case certificatePath = "certificate_path"
        case vision = "vision"
        case more = "more"
        case summary = "summary"
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let title: String
    let logo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case logo = "logo"
    }
}

// MARK: - Subcategory
struct Subcategory: Codable {
    let logoPath: String
    let id: Int
    let title: String
    let categoryID: Int
    let logo: String

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case id = "id"
        case title = "title"
        case categoryID = "category_id"
        case logo = "logo"
    }
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
