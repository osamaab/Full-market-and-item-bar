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
    let logoPath: String?
    
    var imageURL: URL? {
        URL(string: logoPath ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case isSelected = "isSelected"
        case id = "id"
        case categoryID = "category_id"
        case title = "title"
        case logoPath = "logo_path"
    }
}
extension SubCategory: Codable { }

extension SubCategory {
    static func sample(id: Int) -> SubCategory {
        .init(id: id, categoryID: id, isSelected: nil, title: "Category \(id)", logoPath: "http://placekitten.com/200/300")
    }
}
