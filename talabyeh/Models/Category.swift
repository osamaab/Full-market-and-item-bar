//
//  Category.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/18/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import Foundation


struct Category: Codable {
    let ID: Int?
    let title: String?
    let logo: String?
}

struct Categories: Codable {
  let results: [Category]
}
