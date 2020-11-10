//
//  UserType.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/15/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import Foundation

struct UserType: Codable {
    let id: Int?
    let name: String?
    let logo: String?
}

struct Types: Codable {
  let results: [UserType]
}

