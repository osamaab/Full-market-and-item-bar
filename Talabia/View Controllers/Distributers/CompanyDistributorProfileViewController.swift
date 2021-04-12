//
//  CompanyDistributorProfileViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class CompanyDistributorProfileViewController: ProfileViewController<Distributor> {
    
    let router: UnownedRouter<DistributorsRoute>
    let distributor: Distributor
    
    init(distributor: Distributor, router: UnownedRouter<DistributorsRoute>) {
        self.router = router
        self.distributor = distributor
        super.init(contentRepository: ConstantContentRepository(content: distributor))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupItems() -> [ProfileMenuItem] {
        [
            .information(),
            .coveringAreas(),
            .orders(),
            .status(),
            .history()
        ]
    }
    
    override func performAction(for item: ProfileMenuItem.Identifier) {
        switch item {
        case .myInformation:
            router.trigger(.editInformation(distributor))
            break
        case .coveringAreas:
            router.trigger(.coveringAreas(distributor))
            break
        case .orders:
            router.trigger(.orders(distributor))
            break
        case .status:
            router.trigger(.status(distributor))
            break
        case .history:
            router.trigger(.history(distributor))
            break
        default:
            break
        }
    }
}
