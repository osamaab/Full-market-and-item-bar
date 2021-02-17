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
            .information(),
            .items(),
            .changePassword(),
            .companyBranches(),
            .companyProfile(),
            .payment(),
            .history(),
            .settings()
        ]
    }
    
    override func contentRequestDidSuccess(with content: Company) {
        self.headerView.titleLabel.text = content.title
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
