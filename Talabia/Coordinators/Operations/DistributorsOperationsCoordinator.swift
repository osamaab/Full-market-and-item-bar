//
//  DistributorsOperationsCoordinator.swift
//  Talabia
//
//  Created by Osama Abu hdba on 04/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

enum DistributorsOperationsRoute: Route {
    case notLogin
    case home
    
}

class DistributorsOperationsCoordinator: NavigationCoordinator<DistributorsOperationsRoute> {
    
    let authenticationManager = DefaultAuthenticationManager.shared
    let preferencesManager = UserDefaultsPreferencesManager.shared
    init(){
        guard self.authenticationManager.isAuthenticated else {
            super.init(rootViewController: NavigationController(), initialRoute:.notLogin )
            rootViewController.tabBarItem = .operation
            return
        }
        super.init(rootViewController: NavigationController(), initialRoute: .home)
        rootViewController.tabBarItem = .operation
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .notLogin:
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
            vc.title = "Operations"
            return .push(vc)
        case .home:
            let viewController = ChooseUserViewController()
            return .push(viewController)
        }
    }
}
