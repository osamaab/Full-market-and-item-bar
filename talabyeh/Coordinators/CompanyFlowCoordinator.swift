//
//  CompanyFlowCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 28/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum CompanyFlowRoute: Route {
    case market
    case operations
    case items
    case distributors
    case profile
}

class CompanyFlowCoordinator: XCoordinator.TabBarCoordinator<CompanyFlowRoute> {
        
    init(){
        super.init(initialRoute: .market)
    }
}
