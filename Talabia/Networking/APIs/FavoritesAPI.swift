//
//  FavoritesAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum FavoritesAPI: TargetType {
    case products
    case companies
    
    case favoriteProduct(Int, Int) // id, quantity
    case unfavoriteProduct(Int)
    
    case favoriteCompany(Int)
    case unfavoriteCompany(Int)
}

extension FavoritesAPI {
    var path: String {
        switch self {
        case .products:
            return "user/fav_items"
        case .companies:
            return "user/fav_companies"
            
        case .favoriteProduct:
            return "user/fav_items/add"
        case .unfavoriteProduct(let id):
            return "user/fav_items/delete/\(id)"
            
        case .favoriteCompany:
            return "user/fav_companies/add"
        case .unfavoriteCompany(let id):
            return "user/fav_companies/delete/\(id)"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .companies, .products:
            return .get
        case .favoriteProduct, .unfavoriteProduct, .favoriteCompany, .unfavoriteCompany:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .companies, .products, .unfavoriteProduct, .unfavoriteCompany:
            return .requestPlain
        case .favoriteProduct(let id, let quantity):
            return .requestParameters(parameters: ["item_id": id, "quantity": quantity], encoding: JSONEncoding.default)
        case .favoriteCompany(let id):
            return .requestParameters(parameters: ["company_id": id], encoding: JSONEncoding.default)
        }
    }
}
