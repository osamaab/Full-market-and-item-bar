//
//  StoreLocationsAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum StoreLocationsAPI: TargetType {
    case storeLocations
    case new(NewStoreLocation)
    case edit(NewStoreLocation)
    case delete(Int)
    
    
    var path: String {
        switch self {
        case .storeLocations:
            return "user/store_location"
        case .new:
            return "user/store_location/add"
        case .edit:
            return "user/store_location/edit"
        case .delete(let id):
            return "user/store_location/delete/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .storeLocations:
            return .get
        case .new, .delete:
            return .post
        case .edit:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .storeLocations:
            return .requestPlain
        case .new(let form):
            return .requestJSONEncodable(form)
        case .edit(let form):
            return .requestJSONEncodable(form)
        case .delete:
            return .requestPlain
        }
    }
}
