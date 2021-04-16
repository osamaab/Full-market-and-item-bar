//
//  CompanyProfileViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 13/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class CompanyProfileViewController: ProfileViewController<Company> {
    
    let router: UnownedRouter<CompanyProfileRoute>
    
    init(router: UnownedRouter<CompanyProfileRoute>){
        self.router = router
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupItems() -> [ProfileMenuItem] {
        [
//            .information(),
            .items(),
//            .changePassword(),
            .companyBranches(),
            .payment(),
//            .companyProfile(),
            .companyHistory(),
            .favorits(),
            .notification(),
            .settings(),
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
        case .companyProfile:
            router.trigger(.moreInformation)
        case .items:
            router.trigger(.allItems)
        default:
            break
        }
    }
}
