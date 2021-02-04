//
//  AuthenticationAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum AuthenticationAPI {
    
    
    /**
     For a simple parameters, it's better to include them as an associated values, and I used typealias to make sure naming is clear to the client of the API, both username and password are plain string.
     */
    case login(Username, Password)
    
    /**
     In case there is too many fields, it becomes hard to put them all as an associated values, so a better approach would be to group them in a struct ( making sure that the variables names matches the parameters names ), and converting these structs easily to parameters.
     */
    case companyRegister(RegisterationForm.Company)
    case distributorRegister(RegisterationForm.Distributor)
    case resellerRegister(RegisterationForm.Reseller)
    
    case carTypes
}

extension AuthenticationAPI: TargetType {    
    var path: String {
        switch self {
        case .login:
            return "account/login"
        case .companyRegister:
            return "company/register"
        case .distributorRegister:
            return "distributor/register"
        case .resellerRegister:
            return "reseller/register"
        case .carTypes:
            return "car_type/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .companyRegister, .distributorRegister, .resellerRegister:
            return .post
        case .carTypes:
            return .get
        }
    }
    

    var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
        case .companyRegister(let form):
            return .requestParameters(parameters: form.parameters, encoding: JSONEncoding.default)
        case .distributorRegister(let form):
            return .requestParameters(parameters: form.parameters, encoding: JSONEncoding.default)
        case .resellerRegister(let form):
            return .requestParameters(parameters: form.parameters, encoding: JSONEncoding.default)
        case .carTypes:
            return .requestPlain
        }
    }
}
