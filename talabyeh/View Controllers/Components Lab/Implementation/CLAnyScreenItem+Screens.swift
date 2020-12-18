//
//  CLAnyScreenItem+Screens.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

extension CLAnyScreenItem {
    static func getAllAvailable() -> [CLAnyScreenItem] {
        readyClasses().map { CLAnyScreenItem(screenClass: $0) } + [profile()]
    }
    
    static func profile() -> Self {
        CLAnyScreenItem(name: "Profile") { () -> UIViewController in
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
