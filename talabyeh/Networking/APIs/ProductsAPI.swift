//
//  ProductsAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum ProductsAPI {
    
    /**
     yet still I don't know if this api belongs here, but I'll skip this for now, cause it doesn't require authentication nor any additional parameters, so it's most likely belongs here.
     */
    case items
}

extension ProductsAPI: TargetType {
    var path: String {
        switch self {
        case .items:
            return "items"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .items:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .items:
            return .requestPlain
        }
    }
}
