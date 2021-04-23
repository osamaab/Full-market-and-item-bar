//
//  DistributorType.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

enum DistributorType: Int {
    case company = 1
    case personal = 2
    
    var title: String {
        switch self {
        case .company:
            return "Company Distributor"
        case .personal:
            return "Personal Distributor"
        }
    }
}
