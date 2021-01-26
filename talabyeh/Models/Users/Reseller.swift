//
//  Reseller.swift
//  talabyeh
//
//  Created by Hussein Work on 13/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct Reseller: Codable {
    let id: Int
    let name: String
    let email: String
    let facilityNationalNumber: String
    let telephone: String
    let lat: String
    let lng: String
    let commercialLicense: String
    let logoPath: URL?
    let username: String
    let user: User
    let categories: [MainCategory]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case facilityNationalNumber = "facility_national_number"
        case telephone = "telephone"
        case lat = "lat"
        case lng = "lng"
        case commercialLicense = "commercial_license"
        case logoPath = "logo_path"
        case username = "username"
        case user = "user"
        case categories = "categories"
    }
}

/**
 {
     "username":"reseller@yahoo.com",
     "password":"PWD"
 }
 */
