//
//  RegisterationForm.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct RegisterationForm {
    struct Category: Codable {
        let id: Int
    }
    
    struct Reseller: ParametersConvertable {
        let en_title: String
        let email: String
        let password: String
        let national_number: String
        let telephone: String
        let logo_b64: String
        let lat: String
        let lng: String
        let categories: [Category]
    }
    
    struct Distributor: Codable, ParametersConvertable {
        let arName: String
        let enName: String
        let email: String
        let password: String
        let distTypeId: Int
        let nationalNumber: String
        let mobile: String
        let carTypeId: Int

        enum CodingKeys: String, CodingKey {
            case arName = "ar_name"
            case enName = "en_name"
            case email = "email"
            case password = "password"
            case distTypeId = "dist_type_id"
            case nationalNumber = "national_number"
            case mobile = "mobile"
            case carTypeId = "car_type_id"
        }
    }

    struct Company: Codable, ParametersConvertable {
        let arTitle: String
        let enTitle: String
        let email: String
        let password: String
        let nationalNumber: String
        let telephone: String
        let logoUrl: String
        let lat: String
        let lng: String
        let fax: String
        let ext: String
        let categories: [Category]

        enum CodingKeys: String, CodingKey {
            case arTitle = "ar_title"
            case enTitle = "en_title"
            case email = "email"
            case password = "password"
            case nationalNumber = "national_number"
            case telephone = "telephone"
            case logoUrl = "logo_url"
            case lat = "lat"
            case lng = "lng"
            case fax = "fax"
            case ext = "ext"
            case categories = "categories"
        }
    }
}
