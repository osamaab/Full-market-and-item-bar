//
//  CoveringArea.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct CoveringArea: Codable {
    let id: Int
    let title: String
    let lat, lng: String
    let countryID: Int

    enum CodingKeys: String, CodingKey {
        case id, title, lat, lng
        case countryID = "country_id"
    }
}
