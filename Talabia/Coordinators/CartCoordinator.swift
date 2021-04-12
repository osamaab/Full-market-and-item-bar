//
//  CartCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 26/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

enum CartRoute: Route {
    case notLogin
    
    case cart
    case checkout(CartContents)
    case selectPreferredDistributor
}

class CartCoordiantor: NavigationCoordinator<CartRoute> {
    let authenticationManager = DefaultAuthenticationManager.shared
    
    init(){
        guard self.authenticationManager.isAuthenticated else {
            super.init(rootViewController: NavigationController(), initialRoute:.notLogin )
            rootViewController.tabBarItem = .cart
            return
        }
        
        super.init(rootViewController: NavigationController(style: .primary, autoShowsCloseButton: false), initialRoute: .cart)
        rootViewController.tabBarItem = .cart
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
            vc.title = "Cart"
            return .push(vc)
        case .cart:
            return .push(CartItemsViewController(router: self.unownedRouter))
        case .checkout(let cart):
            return .push(CheckoutViewController(router: self.unownedRouter, cart: cart))
        case .selectPreferredDistributor:
            return .push(SelectPreferredDistributorViewController())
        }
    }
}
