//
//  CompanySettingsViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 02/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import Stevia

class CompanySettingsViewController:SettingsViewController<Company>{

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
            .changePassword(),
            .bannerBage(),
            .accountLevel(),
            .contctUs()
        ]
    }
    
    override func performAction(for item: ProfileMenuItem.Identifier) {
        switch item {
        case .password:
            router.trigger(.changePassword)
        case .contctUs:
            router.trigger(.contactUs)
        case .bannerBage:
            router.trigger(.bannerPage)
        case .accountLevel:
            router.trigger(.accountLevel)
        default:
            break
        }
    }
}
