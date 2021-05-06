//
//  DistributorProfileCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

enum DistributorProfileRoute: Route {
    case notLogin
    case profile
    case setting
    case changePassword
}

class DistributorProfileCoordinator: NavigationCoordinator<DistributorProfileRoute> {
    let preferencesManager = UserDefaultsPreferencesManager.shared
    let authenticationManager = DefaultAuthenticationManager.shared
    init(){
        
        guard self.authenticationManager.isAuthenticated else {
            super.init(rootViewController: NavigationController(), initialRoute:.notLogin )
            rootViewController.tabBarItem = .profile
            return
        }
        super.init(rootViewController: NavigationController(), initialRoute: .profile)
        rootViewController.tabBarItem = .profile
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
            vc.title = "Profile"
            return .push(vc)
        case .profile:
            let profile = DistributorProfileViewController(router: self.unownedRouter)
            return .push(profile)
        case .setting:
            let vc = DistributorSettingsViewController(router: self.unownedRouter)
            return .push(vc)
        case .changePassword:
            let router = ChangePasswordCoordinator()
            return .presentFullScreen(router)
        }
    }
}
