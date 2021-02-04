//
//  Distributor.swift
//  talabyeh
//
//  Created by Hussein Work on 13/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct Distributor: Codable {
    let mobile: String
    let personalPicturePath: String
    let id: Int
    let personalIdPath: String
    let distTypeId: Int
    let carLicensePath: String
    let email: String
    let drivingLicensePath: String
    let carTypeId: Int
    let name: String
    let civilId: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case mobile = "mobile"
        case personalPicturePath = "personal_picture_path"
        case id = "id"
        case personalIdPath = "personal_id_path"
        case distTypeId = "dist_type_id"
        case carLicensePath = "car_license_path"
        case email = "email"
        case drivingLicensePath = "driving_license_path"
        case carTypeId = "car_type_id"
        case name = "name"
        case civilId = "civil_id"
        case user
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
