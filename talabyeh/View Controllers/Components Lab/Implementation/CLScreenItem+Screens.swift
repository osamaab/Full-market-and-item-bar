//
//  CLScreenItem+Screens.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

extension CLScreensSection {
    static let profile: CLScreensSection = {
        let screenClasses = [
            CompanyLocationsViewController.self,
            ChangePasswordViewController.self,
            CompanyProfileOptionsViewController.self,
            CertificatesViewController.self
        ]
        
        return CLScreensSection(name: "Profile", items: [CLScreenItem.profile()] + screenClasses.map { CLScreenItem(screenClass: $0) })
    }()
}

extension CLScreenItem {
    static func getAllAvailable() -> [CLScreenItem] {
        readyClasses().map { CLScreenItem(screenClass: $0) } + [profile()]
    }
    
    static func profile() -> Self {
        CLScreenItem(name: "Profile") { () -> UIViewController in
            let headerInfo = ProfileHeaderInfo(title: "Hussein AlRyalat",
                                               imageURL: nil,
                                               subtitle: "hus.sc@aol.com",
                                               subtitle2: nil)
            
            let menuItems = [
                ProfileMenuItem.changePassword(),
                .payment(),
                .orders(),
                .location(),
                .information(),
                .history()
            ]
            
            return ProfilePageViewController(headerInfo: headerInfo, menuItems: menuItems)
        }
    }
    
    static func readyClasses() -> [UIViewController.Type] {
        [
            CompanyLocationsViewController.self,
            ChangePasswordViewController.self,
            CompanyProfileOptionsViewController.self,
            CompanyInformationInputViewController.self,
            CertificatesViewController.self,
            ContactDesignersViewController.self,
            OprationsListViewController.self,
            OperationDetailsViewController.self,
            PaymentCardsPickerViewController.self,
            NewPaymentCreditCardViewController.self,
            CheckoutViewController.self,
            CartItemsViewController.self,
            FavoritesViewController.self,
            DistributersListViewController.self,
            NewDistributerViewController.self,
            MarketViewController.self,
            MarketCategoriesViewController.self,
            ProductDetailsViewController.self,
            AdvancedSearchViewController.self
        ]
    }
}
