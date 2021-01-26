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
}

extension MainCategory: Codable { }