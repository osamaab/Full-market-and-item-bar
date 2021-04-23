//
//  CarType.swift
//  talabyeh
//
//  Created by Hussein Work on 04/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct CarType: Equatable, Hashable {
    let carID: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case carID = "id"
        case title
    }
}

extension CarType: Codable {
    
}
