//
//  ResellerProfileViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class ResellerProfileViewController: ProfileViewController<Reseller> {

    let router: UnownedRouter<ResellerProfileRoute>
    
    init(router: UnownedRouter<ResellerProfileRoute>){
        self.router = router
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupItems() -> [ProfileMenuItem] {
        [
            .information(),
            .resellerBranches(),
            .payment(),
            .companyHistory(),
            .settings(),
            .notification()
        ]
    }
    
    override func performAction(for item: ProfileMenuItem.Identifier) {
        switch item {
        case .editProfile:
            router.trigger(.editProfile)
        case .branches:
            router.trigger(.storeLocations)
        case .myInformation:
            router.trigger(.editCategories)
        case .password:
            router.trigger(.changePassword)
        case .settings:
            router.trigger(.setting)
        case.notification:
            router.trigger(.notification)
        default:
            break
        }
    }
}
