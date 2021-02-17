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
            .changePassword(),
            .resellerBranches(),
            .payment(),
            .history(),
            .settings()
        ]
    }
    
    override func contentRequestDidSuccess(with content: Reseller) {
        self.headerView.titleLabel.text = content.name
        self.headerView.subtitleLabel.text = content.email
        self.headerView.tertiaryLabel.text = content.telephone
        self.headerView.imageView.sd_setImage(with: URL(string: content.logoPath), completed: nil)
    }
    
    
    override func performAction(for item: ProfileMenuItem) {
        switch item.identifier {
        case .branches:
            router.trigger(.storeLocations)
        case .myInformation:
            router.trigger(.editCategories)
        case .password:
            router.trigger(.changePassword)
        default:
            break
        }
    }
}
