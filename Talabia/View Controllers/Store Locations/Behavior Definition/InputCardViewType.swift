//
//  InputCardViewType.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

protocol InputCardViewType {
    associatedtype Output
    
    
    func validateAndReturnData() throws -> Output
}

enum InputCardViewValidationError: String, Error {
    case missingFields
}


