//
//  MarketCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import Promises


enum MarketRoute: Route {
    case home
    case company(Company)
    case allCompanies
    
    case categories([MainCategory])
    
    case favoriteProduct(Product)
    case unfavoriteProduct(Product)
    case favoriteCompany(Company)
    case unfavoriteCompany(Company)
    
    case products(MainCategory)
    case productDetails(Product)
    case categoryDetails(SubCategory)

    case advancedSearch
    case chooseStoreLocation(selected: DeliveryType?, delegate: MarketChooseLocationViewControllerDelegate)
    case login
    case companyMarket(Product)
    case companyInfo
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
            let vc = CompanyDetailsViewController(router: self.unownedRouter, market: .company(company))
            vc.title = "\(company.name)"
            return .push(vc)
        case .products(_):
            fatalError("Not really ready :)")
        case .productDetails(let product):
            let details = ProductDetailsViewController(product: product)
            details.delegate = self
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
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                action: {
                vc.navigationController?.popViewController(animated: true)})
            return .push(vc)
        case .allCompanies:
            let vc = AllCompaniesViewController(contentRepository: AllCompaniesViewController.allCompanyContent())
            return .push(vc)
        case .categoryDetails(let subCategory):
            let vc = CategoryDetailsViewController(router: self.unownedRouter, market:.category(subCategory))
            vc.title = "\(subCategory.title)"
            return .push(vc)
        case .unfavoriteProduct(let product):
            FavoritesAPI.unfavoriteProduct(product.id).request(String.self)
            return .none()
        case .unfavoriteCompany(let company):
            return self.performTask(task: FavoritesAPI.unfavoriteCompany(company.id).request(String.self))
        case .favoriteProduct(let product):
            return self.performTask(task: FavoritesAPI.favoriteProduct(product.id, product.totalQuantity ?? 0).request(String.self))
        case .favoriteCompany(let company):
            return performTask(task: FavoritesAPI.favoriteCompany(company.id).request(String.self))
        case .companyMarket(let companyId):
            let vc = CompanyDetailsViewController(router: self.unownedRouter, market:.companyMarket(companyId))
            return .push(vc)
        case .companyInfo:
            let vc = CompanyMoreInfoViewController(router: unownedRouter.self)
            return .push(vc)
        }
    }
    fileprivate func performTask(task: Promise<String>) -> TransitionType {
        return .none()
    }
}
extension MarketCoordinator: SubCategoriesPickerCoordinatorDelegate {
    func subCategoriesPickerCoordinator(_ sender: SubCategoriesPickerCoordinator, didFinishWith categories: [SubCategory]) {
    }
    
    func chooseUserCoordinatorDidChooseSkip(_ sender: SubCategoriesPickerCoordinator) {
        self.trigger(.home)
    }
}
extension MarketCoordinator: ProductDetailsViewControllerDelegate {
    func ProductDetailsViewControllerDidTapAdd(_ sender: ProductDetailsViewController, didFinishWith product: Product) {
//        let items = Company.self
        self.trigger(.companyMarket(product))
    }
}
