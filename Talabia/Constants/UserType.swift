//
//  UserType.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

enum UserType: Int, CaseIterable, Hashable, Codable {
    case company = 1
    case distributor = 2
    case reseller = 3
    
    
    var title: String {
        switch self {
        case .company:
            return "Company"
        case .distributor:
            return "Distributor"
        case .reseller:
            return "Reseller"
        }
    }
    
    var image: UIImage? {
        return UIImage(named: "auth_\(title.lowercased())")
    }
}
