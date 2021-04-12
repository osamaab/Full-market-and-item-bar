//
//  GeneralAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum GeneralAPI {
    case userTypes
    case categories
    case units
    case areas
    case carTypes
}


/**
 One thing you might notice, is that the baseURL and headers are removed, they are not, instead, they have default values, don't care about them now, as we might discuss them later inshallah.
 */
extension GeneralAPI: TargetType {
    var path: String {
        switch self {
        case .userTypes:
            return "user_type/get_list"
        case .categories:
            return "categories"
        case .units:
            return "units"
        case .areas:
            return "areas"
        case .carTypes:
            return "car_type/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userTypes:
            return .get
        case .categories:
            return .get
        case .units:
            return .get
        case .areas:
            return .get
        case .carTypes:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .userTypes:
            return .requestPlain
        case .categories:
            return .requestPlain
        case .units:
            return .requestPlain
        case .areas:
            return .requestPlain
        case .carTypes:
            return .requestPlain
        }
    }
}

