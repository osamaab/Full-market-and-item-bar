//
//  UserType.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

enum UserType: String, CaseIterable, Hashable {
    case company
    case distributor
    case reseller
    
    
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
        return UIImage(named: "auth_\(rawValue)")
    }
}
