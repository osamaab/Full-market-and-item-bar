//
//  GeneralRoutes.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import Foundation
import Moya


enum GeneralRoutes {
    case userTypes
    case categories
}

extension GeneralRoutes: TargetType {
    var baseURL: URL {
        NetworkConfiguration.current.baseURL
    }
    
    var path: String {
        switch self {
        case .categories:
            return "categories"
        case .userTypes:
            return "get_user_type"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categories, .userTypes:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .userTypes, .categories:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        [:]
    }
}
