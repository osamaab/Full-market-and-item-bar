//
//  NewDistributorInput.swift
//  talabyeh
//
//  Created by Hussein Work on 22/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

// MARK: - NewItemInput
struct NewDistributorInput: Codable {
    let enName: String
    let email: String
    let password: String?
    let mobile: String
   
    let personalIdB64: String?
    let drivingLicenseB64: String?
    let carLicenseB64: String?
    let carPictureB64: String?

    enum CodingKeys: String, CodingKey {
        case enName = "en_name"
        case email = "email"
        case password = "password"
        case mobile = "mobile"
        case personalIdB64 = "personal_id_b64"
        case drivingLicenseB64 = "driving_license_b64"
        case carLicenseB64 = "car_license_b64"
        case carPictureB64 = "car_picture_b64"
    }
}
