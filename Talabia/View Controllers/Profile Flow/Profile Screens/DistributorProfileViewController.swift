//
//  DistributorProfileViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class DistributorProfileViewController: ProfileViewController<Distributor> {
    
    let router: UnownedRouter<DistributorProfileRoute>
    
    init(router: UnownedRouter<DistributorProfileRoute>){
        self.router = router
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupItems() -> [ProfileMenuItem] {
        [
            .information(),
//            .history(),
//            .coveringAreas(),
            .orders(),
            .payment(),
            .notification(),
//            .status(),
            .settings(),
            
        ]
    }
    
    override func contentRequestDidSuccess(with content: Distributor) {
        self.headerView.titleLabel.text = content.name
        self.headerView.subtitleLabel.text = content.email
        self.headerView.tertiaryLabel.text = content.mobile
        self.headerView.imageView.sd_setImage(with: URL(string: content.personalPicturePath ?? ""), completed: nil)
    }
    override func performAction(for item: ProfileMenuItem.Identifier) {
        switch item {
//        case .editProfile:
//            router.trigger(.editProfile)
//        case .branches:
//            router.trigger(.storeLocations)
//        case .myInformation:
//            router.trigger(.editCategories)
//        case .password:
//            router.trigger(.changePassword)
//        case .companyProfile:
//            router.trigger(.moreInformation)
//        case .items:
//            router.trigger(.allItems)
        case .settings:
            router.trigger(.setting)
        default:
            break
        }
    }
}

