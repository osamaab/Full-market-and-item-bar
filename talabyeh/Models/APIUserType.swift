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
    let name: String
    let logo: URL?
}

extension APIUserType: Codable { }
