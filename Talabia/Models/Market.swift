//
//  Market.swift
//  talabyeh
//
//  Created by Hussein Work on 09/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct Market: Codable {
    let bannerUrl: String?
    let companies: [Company]?
    let hotSellingItems: [Product]?
    let subcategories: [SubCategory]?
    
    var bannerURL: URL? {
        URL(string: bannerUrl ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case bannerUrl = "banner_url"
        case companies = "companies"
        case hotSellingItems = "hot_selling_items"
        case subcategories = "subcategories"
    }
}
