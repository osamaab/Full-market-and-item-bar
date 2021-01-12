//
//  ProductUnit.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct ProductUnit: Equatable, Hashable {
    let id: Int
    let title: String
}

extension ProductUnit: Codable { }
