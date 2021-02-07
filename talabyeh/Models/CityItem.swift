//
//  CityItem.swift
//  talabyeh
//
//  Created by Hussein Work on 07/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct CityItem: Equatable, Hashable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

extension CityItem: Codable {}
