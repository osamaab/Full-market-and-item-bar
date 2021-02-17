//
//  FavoritesCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator
import Promises

enum FavoritesRoute: Route {
    case favorites
   
    case unfavoriteProduct(Product)
    case unfavoriteCompany(Company)
    
    case favoriteProduct(Product)
    case favoriteCompany(Company)
}

class FavoritesCoordinator: NavigationCoordinator<FavoritesRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .favorites)
        rootViewController.tabBarItem = .favorites
    }
    
    init(initialRoute: FavoritesRoute){
        super.init(rootViewController: NavigationController(), initialRoute: initialRoute)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .favorites:
            let favoritesVC = FavoritesContainerViewController(router: self.unownedRouter)
            return .push(favoritesVC)
        case .unfavoriteProduct(let product):
            return self.performTask(task: FavoritesAPI.unfavoriteProduct(product.itemID).request(String.self))
        case .unfavoriteCompany(let company):
            return self.performTask(task: FavoritesAPI.unfavoriteCompany(company.id).request(String.self))
        case .favoriteProduct(let product):
            return self.performTask(task: FavoritesAPI.favoriteProduct(product.itemID, product.quantity).request(String.self))
            
        case .favoriteCompany(let company):
            return performTask(task: FavoritesAPI.favoriteCompany(company.id).request(String.self))
        }
    }
    
    fileprivate func performTask(task: Promise<String>) -> TransitionType {
        rootViewController.performTask(taskOperation: task).then {
            self.rootViewController.showMessage(message: $0, messageType: .success)
        }
        
        return .none()
    }
}
