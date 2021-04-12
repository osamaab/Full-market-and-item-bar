//
//  MarketAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 01/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum MarketAPI {
    case market(Int?, Int?)
    case companyMarket(Int)
    
    
    case advancedSearchProducts(Int?, String?)
    case advancedSearchCompanies(Int?, Int?, String?)
}

extension MarketAPI: TargetType {
    var path: String {
        switch self {
        case .market:
            return  "non_user/market"
        case .companyMarket(let id):
            return "company/market/\(id)"
        
        case .advancedSearchProducts:
            return "user/items/filter"
        case .advancedSearchCompanies:
            return "companies/filter"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .market:
        return .post
        case  .companyMarket:
            return .get
        case .advancedSearchCompanies, .advancedSearchProducts:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case  .companyMarket:
            return .requestPlain
        case .advancedSearchCompanies(let catID, let cityID, let text):
            return .requestParameters(parameters: ["category_id": catID, "city_id": cityID, "name": text ?? ""], encoding: URLEncoding.default)
        case .advancedSearchProducts(let catID, let text):
            return .requestParameters(parameters: ["name": text ?? "", "category_id": catID], encoding: URLEncoding.default)
        case .market:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .market(let limit, let offset):
            return [
                "limit": limit,
                "offset": offset
            ].compactMapValues { $0 == nil ? nil : "\($0!)" }
        default:
            return [:]
        }
    }
}
