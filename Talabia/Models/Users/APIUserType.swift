//
//  UserType.swift
//  talabyeh
//
//  Created by Hussein Work on 07/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct APIUserType: Equatable, Hashable {
 
    
    let id: Int
    let identifier: String
    let name: String
    let logo: URL?
    
//    init(id: Int,identifier: String,name: String,logo: URL? ) {
//        self.id = id
//        self.identifier = identifier
//        self.name = name
//        self.logo = logo
//    }
}

extension APIUserType: Codable { }

