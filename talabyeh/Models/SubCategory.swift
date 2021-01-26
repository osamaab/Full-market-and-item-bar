//
//  SubCategory.swift
//  talabyeh
//
//  Created by Hussein Work on 20/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct SubCategory: Equatable, Hashable {
    let id: Int
    let categoryID: Int
    let isSelected: Bool?
    let title: String
    let imageURL: URL?

    enum CodingKeys: String, CodingKey {
        case isSelected = "isSelected"
        case id = "id"
        case categoryID = "category_id"
        case title = "title"
        case imageURL = "logo_path"
    }
}
extension SubCategory: Codable { }
