//
//  Emptiable.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

protocol Emptiable {
    
    var isEmpty: Bool { get }
    
    var emptyMessage: String? { get }
}

extension Array: Emptiable {
    var emptyMessage: String? {
        "No Data availbale"
    }
}
