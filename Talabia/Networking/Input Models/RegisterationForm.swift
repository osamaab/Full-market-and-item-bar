//
//  RegisterationForm.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct CategoriesIDInput {
    let id: Int
}

extension CategoriesIDInput: Codable {
    
}
struct SubCategoriesIDInput {
    let id: Int
}

extension SubCategoriesIDInput: Codable {
    
}

struct RegisterationForm {
    struct Category: ParametersConvertable {
        let id: Int
    }
    
    struct Reseller: Codable {
        let enName: String
        let email: String?
        let password: String?
        let facilityNationalNumber: String?
        let telephone: String?
        let lat: String?
        let lng: String?
        let logoB64: String?
        let categories: [CategoriesIDInput]
        let subcategories: [SubCategoriesIDInput]
        
        enum CodingKeys: String, CodingKey {
                case enName = "en_name"
                case email = "email"
                case password = "password"
                case facilityNationalNumber = "facility_national_number"
                case telephone = "telephone"
                case lat = "lat"
                case lng = "lng"
                case logoB64 = "logo_b64"
                case categories = "categories"
                case subcategories = "subcategories"
        }
    }
    
    struct Distributor: ParametersConvertable {
        let en_name: String
        let email: String?
        let password: String?
        let dist_type_id: Int
        let national_number: String
        let mobile: String
        let personal_picture_b64: String
        let car_type_id: Int
    }

    struct Company: Codable {
        let enTitle: String?
        let email: String?
        let password: String?
        let nationalNumber: String?
        let telephone: String?
        let lat: String?
        let lng: String?
        let logoB64: String?
        let categories: [CategoriesIDInput]
        let subcategories:[SubCategoriesIDInput]

        enum CodingKeys: String, CodingKey {
            case enTitle = "en_title"
            case email = "email"
            case password = "password"
            case nationalNumber = "national_number"
            case telephone = "telephone"
            case lat = "lat"
            case lng = "lng"
            case logoB64 = "logo_b64"
            case categories = "categories"
            case subcategories = "subcategories"
        }
    }
}
    


