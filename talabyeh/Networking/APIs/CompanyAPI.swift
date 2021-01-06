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
    case item
    case branches
    case allCompanies
    case operationStatusList
    case items
    
    var path: String {
        switch self {
        case .item:
            return "company_item/13"
        case .branches:
            return "company/get_company_branches/13"
        case .allCompanies:
            return "companies"
        case .operationStatusList:
            return "operation_status/list"
        case .items:
            return "company_item/13"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .item,.items,.allCompanies,.branches,.operationStatusList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .item,.items,.allCompanies,.branches,.operationStatusList:
            return .requestPlain
        }
    }
}
