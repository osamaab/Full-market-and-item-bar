//
//  UserTypeModel.swift
//  talabyeh
//
//  Created by Hussein Work on 25/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

protocol UserTypeModel: Codable {
    
}

extension Company: UserTypeModel {
    
}

extension Distributor: UserTypeModel {
    
}

extension Reseller: UserTypeModel {
    
}
