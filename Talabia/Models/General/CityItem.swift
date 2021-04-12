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
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

extension CityItem: Codable {}
