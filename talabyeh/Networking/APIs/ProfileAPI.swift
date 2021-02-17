//
//  ProfileAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 13/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum ProfileAPI: TargetType {
    case profile
    case changePassword(String, String) // old pas, new pass
}

extension ProfileAPI {
    var path: String {
        switch self {
        case .profile:
            return "user/profile"
        case .changePassword:
            return "user/change_password"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .profile:
            return .get
        case .changePassword:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .profile:
            return .requestPlain
        case .changePassword(let old, let new):
            return .requestParameters(parameters: ["password": old, "new_password": new], encoding: JSONEncoding.default)
        }
    }
}
