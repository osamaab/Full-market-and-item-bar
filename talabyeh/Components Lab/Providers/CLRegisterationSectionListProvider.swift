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
            CLScreenItem(name: "City Picker", creationHandler: { () -> UIViewController in
                return CityPickerViewController(contentRepository: ConstantContentRepository(content: [
                    CityItem(id: 1, title: "Amman"),
                    CityItem(id: 2, title: "Irbid"),
                    CityItem(id: 3, title: "AlKarak")
                ]))
            }),
            
            CLScreenItem(name: "New Company Branch", creationHandler: { () -> UIViewController in
                return CompanyNewStoreLocationViewController()
            })
        ]
        
        return CLScreensSection(name: "In Progress", items: items)
    }()
    
    let profile: CLScreensSection = {
        let screenClasses = [
            ChangePasswordViewController.self,
            CompanyProfileOptionsViewController.self,
            CompanyInformationInputViewController.self,
            CertificatesViewController.self,
            ContactDesignersViewController.self
        ]
        
        return CLScreensSection(name: "Profile", items: screenClasses.map { CLScreenItem(screenClass: $0) })
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
            FavoritesContainerViewController.self,
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
