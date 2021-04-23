//
//  OrderHistoryItem.swift
//  talabyeh
//
//  Created by Hussein Work on 24/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct OrderHistoryItem {
    let month: Int
    let year: Int
    let orderHeaderIds: String

    enum CodingKeys: String, CodingKey {
        case month = "month"
        case year = "year"
        case orderHeaderIds = "order_header_ids"
    }
}

extension OrderHistoryItem: Codable {
    
}
