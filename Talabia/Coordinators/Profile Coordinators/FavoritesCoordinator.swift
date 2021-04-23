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
    case notLogin
        
    case favorites
   
    case unfavoriteProduct(Product)
    case unfavoriteCompany(Company)
    
    case favoriteProduct(Product)
    case favoriteCompany(Company)
}

class FavoritesCoordinator: NavigationCoordinator<FavoritesRoute> {
    let authenticationManager = DefaultAuthenticationManager.shared
    init(){
        guard self.authenticationManager.isAuthenticated else {
            super.init(rootViewController: NavigationController(), initialRoute:.notLogin )
            rootViewController.tabBarItem = .favorites
            return
        }
        super.init(rootViewController: NavigationController(), initialRoute: .favorites)
        rootViewController.tabBarItem = .favorites
    }
    
    init(initialRoute: FavoritesRoute){
        super.init(rootViewController: NavigationController(), initialRoute: initialRoute)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .notLogin:
            let vc = chooseSigninOrSignUpViewController
                { method in
                    switch method {
                    case .signUp:
                        AppDelegate.shared.router.trigger(.chooseUserType, completion: nil)
                        break
                    
                    case .signIn:
                        AppDelegate.shared.router.trigger(.authentication(.signin), completion: nil)
                        break
                    }
                }
            vc.title = "Favorites"
            return .push(vc)
        case .favorites:
            let favoritesVC = FavoritesContainerViewController(router: self.unownedRouter)
            return .push(favoritesVC)
        case .unfavoriteProduct(let product):
            return self.performTask(task: FavoritesAPI.unfavoriteProduct(product.id).request(String.self))
        case .unfavoriteCompany(let company):
            return self.performTask(task: FavoritesAPI.unfavoriteCompany(company.id).request(String.self))
        case .favoriteProduct(let product):
            return self.performTask(task: FavoritesAPI.favoriteProduct(product.id, product.totalQuantity).request(String.self))
            
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
