//
//  ItemsAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 17/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum ItemsAPI {
    
    case productTemplates
    case myProducts
    case marketProducts
    
    case new(NewItemInput)
    case remove(Int)
    case newQuantity(NewProductQuantityInput)
}

extension ItemsAPI: TargetType {
    var path: String {
        switch self {
        case .productTemplates:
            return "items"
        case .myProducts:
            return "user/items"
        case .marketProducts:
            return "user/items"
        case .new:
            return "user/items/add"
        case .remove(let id):
            return "user/items/deactivate/\(id)"
        case .newQuantity:
            return "user/items/add_quantity"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .productTemplates, .myProducts, .marketProducts:
            return .get
        case .new, .newQuantity:
            return .post
        case .remove:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .productTemplates, .myProducts, .marketProducts:
            return .requestPlain
        case .new(let input):
            return .requestJSONEncodable(input)
        case .newQuantity(let input):
            return .requestJSONEncodable(input)
        case .remove:
            return .requestPlain
        }
    }
}

