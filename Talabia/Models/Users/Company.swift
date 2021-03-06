//
//  Company.swift
//  talabyeh
//
//  Created by Hussein Work on 13/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct Company: Equatable, Hashable {
    let id: Int
    let title: String
    let email: String
    let nationalNumber: String
    let telephone: String
    let logoPath: String
    let lat: String
    let lng: String
    let fax: String
    let ext: String
    let user: User?
    let categories: [MainCategory]?
    let subcategories: [SubCategory]?
    let registeredDate: String
    var isSelected: Bool?
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    mutating func setSsSelected(isSelected: Bool) {
        self.isSelected = isSelected
    }
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case email = "email"
        case nationalNumber = "national_number"
        case telephone = "telephone"
        case logoPath = "logo_path"
        case lat = "lat"
        case lng = "lng"
        case fax = "fax"
        case ext = "ext"
        case user = "user"
        case categories = "categories"
        case subcategories = "subcategories"
        case registeredDate = "registered_date"
    }
}

extension Company: Codable { }
