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
    case categories
    case products(ProductCategory)
    case productDetails(Product)
    case advancedSearch
}

class MarketCoordinator: NavigationCoordinator<MarketRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .home)
        rootViewController.tabBarItem = .market
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .home:
            let market = MarketViewController()
            return .push(market)
        case .categories:
            let categories = MarketCategoriesViewController()
            return .push(categories)
        case .products(let category):
            fatalError("Not really ready :)")
        case .productDetails(let product):
            let details = ProductDetailsViewController()
            return .push(details)
        case .advancedSearch:
            let advancedSearch = AdvancedSearchViewController()
            let navigationController = advancedSearch.embededInNavigationController(style: .primary, autoShowsCloseButton: true, showsNavigationBar: true)
            
            return .presentFullScreen(navigationController)
        }
    }
}
