//
//  GeneralUserAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

enum GeneralUser: TargetType{
    case userFavoriteCompanies(String)
    
    var path: String {
        switch self {
        case .userFavoriteCompanies(let username):
            return "user/fav_companies/\(username)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userFavoriteCompanies:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .userFavoriteCompanies:
            return .requestPlain
        }
    }
}
