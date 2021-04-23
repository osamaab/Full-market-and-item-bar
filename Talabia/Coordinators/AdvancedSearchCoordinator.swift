//
//  AdvancedSearchCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 02/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

struct ASCompanySearchQuery {
    let name: String?
    let category: SubCategory?
    let city: CityItem?
}

struct ASItemSearchQuery {
    let name: String?
    let category: SubCategory?
}

enum AdvancedSearchRoute: Route {
    case advancedSearch
    
    case searchCompanies(ASCompanySearchQuery)
    case searchItems(ASItemSearchQuery)
    
    case productDetails(Product)
}

class AdvancedSearchCoordinator: NavigationCoordinator<AdvancedSearchRoute> {
    init(){
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: .advancedSearch)
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .advancedSearch:
            let advancedSearch = ASSearchViewController(router: self.unownedRouter)            
            return .push(advancedSearch)
        case .searchCompanies(let query):
            let viewController = ASCompaniesViewController(router: self.unownedRouter, name: query.name, cityID: query.city?.id, categoryID: query.category?.id)
            
            return .push(viewController)
        case .searchItems(let query):
            let viewController = ASProductsViewController(router: self.unownedRouter, name: query.name, categoryID: query.category?.id)
            
            return .push(viewController)
        case .productDetails(let product):
            return .push(ProductDetailsViewController(product: product))
        }
    }
}
