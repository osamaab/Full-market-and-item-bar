//
//  Validators.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct EmailValidatorType: ValidatorType {
    func validated(_ input: String?) throws -> String {
        guard let input = input else {
            throw ValidationError("Please Enter e-mail Address")
        }
        
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return input
    }
}



struct MaxCharactersValidatorType: ValidatorType {
    
    let maxCharactersCount: Int
    let name: String?
    
    init(maxCharactersCount: Int, fieldName: String?){
        self.name = fieldName
        self.maxCharactersCount = maxCharactersCount
    }
    
    func validated(_ input: String?) throws -> String {
        guard let input = input else {
            throw ValidationError("This field is required")
        }
        
        if input.count > maxCharactersCount {
            if let name = self.name {
                throw ValidationError("\(name) should be \(maxCharactersCount) character maximum")
            } else {
                throw ValidationError("Should be \(maxCharactersCount) character maximum")
            }
        }
        
        return input
    }
}

