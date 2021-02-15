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
}

extension ProfileAPI {
    var path: String {
        switch self {
        case .profile:
            return "user/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .profile:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .profile:
            return .requestPlain
        }
    }
}
