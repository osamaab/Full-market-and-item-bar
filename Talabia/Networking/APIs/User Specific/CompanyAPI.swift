//
//  CompanyAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum CompanyAPI: TargetType {
    case item(Int)
    case branches(Int)
    case allCompanies
    case operationStatusList
    case items(Int)
    case orderHistoryCategories
    
    var path: String {
        switch self {
        case .item(let id):
            return "company_item/\(id)"
        case .branches(let id):
            return "company/get_company_branches/\(id)"
        case .allCompanies:
            return "companies"
        case .operationStatusList:
            return "operation_status/list"
        case .items(let id):
            return "company_item/\(id)"
        case .orderHistoryCategories:
            return "company/orders/history"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .item,.items,.allCompanies,.branches, .operationStatusList, .orderHistoryCategories:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .item,.items,.allCompanies,.branches,.operationStatusList, .orderHistoryCategories:
            return .requestPlain
        }
    }
}
