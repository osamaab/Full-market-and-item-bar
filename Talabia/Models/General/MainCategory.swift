//
//  ProductCategory.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct MainCategory: Equatable, Hashable {
    let id: Int
    let title: String
    let logo: URL?
    var subcategories: [SubCategory]?
    
    internal init(id: Int, title: String, logo: URL?, subcategories: [SubCategory]) {
        self.id = id
        self.title = title
        self.logo = logo
        self.subcategories = subcategories
    }
}

extension MainCategory: Codable { }

