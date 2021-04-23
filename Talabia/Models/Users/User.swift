//
//  User.swift
//  talabyeh
//
//  Created by Hussein Work on 17/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation


// MARK: - User
struct User: Codable {
    let username: String
    let email: String
    let token: String
    let userType: APIUserType?

    enum CodingKeys: String, CodingKey {
        case username = "username"
        case email = "email"
        case token = "token"
        case userType = "user_type"
    }
}

