//
//  DistributorSettingsViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 02/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class DistributorSettingsViewController: SettingsViewController<Distributor> {
    let router: UnownedRouter<DistributorProfileRoute>
    
    init(router: UnownedRouter<DistributorProfileRoute>){
        self.router = router
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setupViewsBeforeTransitioning() {
//        title = "Settings"
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), action: {            self.navigationController?.popViewController(animated: true)
//        })
//        view.subviewsPreparedAL {
//            collectionView
//        }
//        collectionView.leading(0).trailing(0).bottom(0).top(0)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.reloadData()
//        collectionView.contentInset.top = 15
//        
//    }
    
    
    override func setupItems() -> [ProfileMenuItem] {
        [
//            .language(),
            .changePassword()
        ]
    }
    
    override func performAction(for item: ProfileMenuItem.Identifier) {
        switch item {
//        case .editProfile:
//            router.trigger(.editProfile)
//        case .branches:
//            router.trigger(.storeLocations)
//        case .myInformation:
//            router.trigger(.editCategories)
        case .password:
            router.trigger(.changePassword)
//        case .companyProfile:
//            router.trigger(.moreInformation)
//        case .items:
//            router.trigger(.allItems)
//        case .settings:
       //            router.trigger(.)
        default:
            break
        }
    }
}
