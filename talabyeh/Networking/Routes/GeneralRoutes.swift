//
//  GeneralRoutes.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation
import Moya

enum GeneralRoutes {
    case userTypes
    case categories
}

extension GeneralRoutes: TargetType {
    
    var baseURL: URL {
        URL(string: "http://www.talabyeh.com/Api")!
    }
    
    var path: String {
        switch self {
        case .userTypes:
            return "get_user_type"
        case .categories:
            return "categories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userTypes:
            return .get
        case .categories:
            return .get
        }
    }
    
    var headers: [String : String]? {
        [:]
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .userTypes:
            return .requestPlain
        case .categories:
            return .requestPlain
        }
    }
}
