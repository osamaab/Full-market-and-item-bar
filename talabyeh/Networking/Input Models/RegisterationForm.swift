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
    
    struct Distributor: ParametersConvertable {
        let arName: String
        let enName: String
        let email: String
        let password: String
        let distTypeId: Int
        let nationalNumber: String
        let mobile: String
        let carTypeId: Int
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
