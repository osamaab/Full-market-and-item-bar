//
//  CLScreenItem+Screens.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 The lab view controller uses reflection to get properties of the default registration
 */
struct CLScreensDefaultRegisteration {
    let profile: CLScreensSection = {
        let screenClasses = [
            CompanyLocationsViewController.self,
            ChangePasswordViewController.self,
            CompanyProfileOptionsViewController.self,
            CompanyInformationInputViewController.self,
            CertificatesViewController.self,
            ContactDesignersViewController.self,
        ]
        
        let profile = CLScreenItem(name: "Profile") { () -> UIViewController in
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
        
        return CLScreensSection(name: "Profile", items: [profile] + screenClasses.map { CLScreenItem(screenClass: $0) })
    }()
    
    let items: CLScreensSection = {
        let screenClasses = [
            ItemCategoriesViewController.self,
            ItemsChooseCategoryViewController.self,
            ItemsViewController.self,
            NewItemViewController.self
        ]
        
        return CLScreensSection(name: "Items", items: screenClasses.map { CLScreenItem(screenClass: $0) })
    }()
    
    let operations: CLScreensSection = {
        let screenClasses = [
            OprationsListViewController.self,
            OperationDetailsViewController.self,
        ]
        
        return CLScreensSection(name: "Operations", items: screenClasses.map { CLScreenItem(screenClass: $0) })
    }()
    
    let distributors: CLScreensSection = {
        let screenClasses = [
            DistributersListViewController.self,
            NewDistributerViewController.self,
            TrackDistributorViewController.self
        ]
        
        let existingScreen = CLScreenItem(name: "Select Existing Distributor") {
            SelectExistingDistributorViewController()
        }
        
        let externalScreen = CLScreenItem(name: "Select External Distributor"){
            SelectExternalViewController()
        }
        
        return CLScreensSection(name: "Distributors", items: screenClasses.map { CLScreenItem(screenClass: $0) } + [existingScreen, externalScreen])
    }()
    
    let others: CLScreensSection = {
        let screenClasses = [
            PaymentCardsPickerViewController.self,
            NewPaymentCreditCardViewController.self,
            CheckoutViewController.self,
            CartItemsViewController.self,
            FavoritesViewController.self,
            MarketViewController.self,
            MarketCategoriesViewController.self,
            ProductDetailsViewController.self,
            AdvancedSearchViewController.self
        ]
        
        return CLScreensSection(name: "Others", items: screenClasses.map { CLScreenItem(screenClass: $0) })
    }()
}
