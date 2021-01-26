//
//  CLRegisterationSectionListProvider.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

struct CLRegisterationSectionListProvider: CLScreenSectionListProvider {
    
    let inProgress: CLScreensSection = {
        let items: [CLScreenItem] = [
            CLScreenItem(name: "Categories Picker", creationHandler: { () -> UIViewController in
                return CategoriesPickerViewController(title: "Pick Categories")
            })
        ]
        
        return CLScreensSection(name: "In Progress", items: items)
    }()
    
    let profile: CLScreensSection = {
        let screenClasses = [
            CompanyLocationsViewController.self,
            ChangePasswordViewController.self,
            CompanyProfileOptionsViewController.self,
            CompanyInformationInputViewController.self,
            CertificatesViewController.self,
            ContactDesignersViewController.self,
            DeliveryAreaPickerViewController.self
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
    
    let marketSpecific: CLScreensSection = {
        let screenClasses = [
            MarketSelectDistributorViewController.self,
            MarketEditProfileViewController.self,
            MarketChangePasswordViewController.self,
            CheckoutViewController.self,
            CartItemsViewController.self,
            FavoritesViewController.self,
            MarketStoreLocationFieldsViewController.self
        ]
        
        return CLScreensSection(name: "Market Specific", items: screenClasses.map { CLScreenItem(screenClass: $0) })
    }()
    
    let payments: CLScreensSection = {
        let screenClasses = [
            PaymentCardsPickerViewController.self,
            NewPaymentCreditCardViewController.self,
        ]
        
        return CLScreensSection(name: "Payments", items: screenClasses.map { CLScreenItem(screenClass: $0) })

    }()
    
    let products: CLScreensSection = {
        let screenClasses = [
            MarketViewController.self,
            MarketCategoriesViewController.self,
            ProductDetailsViewController.self,
            AdvancedSearchViewController.self
        ]
        
        return CLScreensSection(name: "Products", items: screenClasses.map { CLScreenItem(screenClass: $0) })
    }()

}



extension CLRegisterationSectionListProvider {
    func sections() -> [CLScreensSection] {
        let screensMirror = Mirror(reflecting: self)
        
        
        var screenSections: [CLScreensSection] = []
        for element in screensMirror.children {
            if let screenSection = element.value as? CLScreensSection {
                screenSections.append(screenSection)
            }
        }
        
        return screenSections
    }
}
