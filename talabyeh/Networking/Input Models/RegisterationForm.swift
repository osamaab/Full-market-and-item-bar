//
//  RegisterationForm.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct RegisterationForm {
    struct Category: ParametersConvertable {
        let id: Int
    }
    
    struct Reseller: ParametersConvertable {
        let en_name: String
        let email: String
        let password: String
        let national_number: String
        let telephone: String
        let picture: String
        let lat: String
        let lng: String
        let categories: [[String: Any]]
    }
    
    struct Distributor: ParametersConvertable {
        let en_name: String
        let email: String
        let password: String
        let dist_type_id: Int
        let national_number: String
        let mobile: String
        let personal_picture_b64: String
        let car_type_id: Int
    }

    struct Company: ParametersConvertable {
        let enTitle: String
        let email: String
        let password: String
        let national_number: String
        let telephone: String
        let logo_b64: String
        let lat: String
        let lng: String
        let categories: [[String: Any]]
    }
}
