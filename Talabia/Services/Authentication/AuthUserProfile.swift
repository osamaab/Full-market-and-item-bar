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


extension AuthUserProfile: Codable {
    init(from decoder: Decoder) throws {
        if let company = try? Company.init(from: decoder) {
            self = .company(company)
        } else if let reseller = try? Reseller.init(from: decoder) {
            self = .reseller(reseller)
        } else {
            let distributor = try Distributor.init(from: decoder)
            self = .distributor(distributor)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        switch self {
        case .company(let com):
            try com.encode(to: encoder)
        case .distributor(let dis):
            try dis.encode(to: encoder)
        case .reseller(let res):
            try res.encode(to: encoder)
        }
    }
}
