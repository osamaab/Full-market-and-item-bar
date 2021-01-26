//
//  Distributor.swift
//  talabyeh
//
//  Created by Hussein Work on 13/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct Distributor: Codable {
    let id: Int

    let name: String
    let email: String
    let mobile: String

    let personalPicturePath: URL?
    
    let civilId: String
    let username: String
    let personalId: String
    let drivingLicense: String

    let cardHolderName: String
    let cardNumber: String
    let month: Int
    let year: Int
    let cvvNumber: String

    let user: User
    
    let distributorType: DistributorType
    let carType: DistributorCarType

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
        case personalPicturePath = "personal_picture_path"
        case civilId = "civil_id"
        case username = "username"
        case personalId = "personal_id"
        case drivingLicense = "driving_license"
        case cardHolderName = "card_holder_name"
        case cardNumber = "card_number"
        case month = "month"
        case year = "year"
        case cvvNumber = "cvv_number"
        case user = "user"
        case distributorType = "distributor_type"
        case carType = "car_type"
    }
}

struct DistributorType: Codable {
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }
}

struct DistributorCarType: Codable {
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }
}


/**
 {
     "username":"hussc@dominate.dev",
     "password":"123456"
 }
 */
