//
//  DistributorsAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 22/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum DistributorsAPI {
    case list
    case profile(Int)
    case create(NewDistributorInput)
    
    case coveringAreas
    case editCoveringAreas([CategoriesIDInput])
    
    case orderHistoryCategories
}

extension DistributorsAPI: TargetType {
    
    var path: String {
        switch self {
        case .list:
            return "company/distributors/list"
        case .profile(let id):
            return "company/distributors/\(id)"
        case .create:
            return "company/distributors/add"
        case .coveringAreas:
            return "distributor/delivery_areas"
        case .editCoveringAreas:
            return "distributor/delivery_areas/update"
        case .orderHistoryCategories:
            return "distributor/orders/history"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list, .profile, .coveringAreas, .orderHistoryCategories:
            return .get
        case .create, .editCoveringAreas:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .list, .profile, .coveringAreas, .orderHistoryCategories:
            return .requestPlain
        case .create(let form):
            return .requestJSONEncodable(form)
        case .editCoveringAreas(let form):
            return .requestJSONEncodable(form)
        }
    }
}
