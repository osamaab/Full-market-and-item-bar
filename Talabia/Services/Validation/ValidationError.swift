//
//  ValidationError.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct ValidationError: Error {
    let message: String
    
    init(_ message: String){
        self.message = message
    }
}
