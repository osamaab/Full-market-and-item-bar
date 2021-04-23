//
//  ResponseContainer.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct ResponseStatus: Codable {
    let message: String
    let code: Int
}

struct ResponseContainer<C> {
    let results: C?
    let status: ResponseStatus
}

extension ResponseContainer: Codable where C: Codable {
    
}
