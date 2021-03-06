//
//  MarketCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator



enum MarketRoute: Route {
    case home
    case company(Company)
    case allCompanies
    
    case categories([MainCategory])
    
    case products(MainCategory)
    case productDetails(Product)

    case advancedSearch
    case chooseStoreLocation(selected: DeliveryType?, delegate: MarketChooseLocationViewControllerDelegate)
    case login
}

class MarketCoordinator: NavigationCoordinator<MarketRoute> {
    
    let preferencesManager = UserDefaultsPreferencesManager.shared
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .home)
        rootViewController.tabBarItem = .market
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .home:
            let market = MarketViewController(router: self.unownedRouter, market: .full)
            return .push(market)
        case .categories(let categories):
            let categories = MarketCategoriesViewController(contentRepository: ConstantContentRepository(content: categories))
            return .push(categories)
        case .company(let company):
            return .push(MarketViewController(router: self.unownedRouter, market: .company(company)))
        case .products(_):
            fatalError("Not really ready :)")
        case .productDetails(let product):
            let details = ProductDetailsViewController(product: product)
            return .push(details)
        case .advancedSearch:
            let router = AdvancedSearchCoordinator().strongRouter
            return .presentFullScreen(router)
        case .chooseStoreLocation(let location, let delegate):
            MarketChooseLocationViewController(selectedLocation: location, delegate: delegate).present()
            return .none()
        case .login:
            
            let vc = chooseSigninOrSignUpViewController
                { method in
                    switch method {
                    case .signUp:
                        self.preferencesManager.didTappedSignUp = true
                        AppDelegate.shared.router.trigger(.chooseUserType, completion: nil)
                        break
                    
                    case .signIn:
                        AppDelegate.shared.router.trigger(.authentication(.signin), completion: nil)
                        break
                    }
                }
            vc.title = "Market"
            return .push(vc)
        case .allCompanies:
            let vc = AllCompaniesViewController(contentRepository: AllCompaniesViewController.allCompanyContent())
           
            return .push(vc)        }
    }
}
extension MarketCoordinator: SubCategoriesPickerCoordinatorDelegate {
    func subCategoriesPickerCoordinator(_ sender: SubCategoriesPickerCoordinator, didFinishWith categories: [SubCategory]) {
    }
    
    func chooseUserCoordinatorDidChooseSkip(_ sender: SubCategoriesPickerCoordinator) {
        self.trigger(.home)
    }
    
    
    
    
}
