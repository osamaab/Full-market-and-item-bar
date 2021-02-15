//
//  AuthUserProfile.swift
//  talabyeh
//
//  Created by Hussein Work on 17/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

enum AuthUserProfile {
    case company(Company)
    case distributor(Distributor)
    case reseller(Reseller)
    
    var userType: UserType {
        switch self {
        case .company:
            return .company
        case .distributor:
            return .distributor
        case .reseller:
            return .reseller
        }
    }
    
    var associatedData: UserModelType {
        switch self {
        case .company(let obj):
            return obj
        case .distributor(let obj):
            return obj
        case .reseller(let obj):
            return obj
        }
    }
}
