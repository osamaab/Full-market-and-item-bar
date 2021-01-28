//
//  AuthenticationCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator


enum UserTypeEnum {
    case Company
    case Distributor
    case Reseller
}

enum AuthenticationRoute: Route {
    case signin(UserType)
    case distributorSignup
    case companySignup
    case resellerSignup
}

protocol AuthenticationCoordinatorDelegate: class {
    func authenticationCoordinator(_ sender: AuthenticationCoordinator, didFinishWith profile: AuthUserProfile)
}

/**
 So the clients don't wanna really care about how the authentication flow "internally" works, right now, the implementation does things with storyboards and xib's, and that's againest our guidelines for doing things, but this should not affect other parts of the app.
 */
class AuthenticationCoordinator: NavigationCoordinator<AuthenticationRoute> {
    
    weak var coordinatorDelegate: AuthenticationCoordinatorDelegate?
    
    init(delegate: AuthenticationCoordinatorDelegate, initialRoute: AuthenticationRoute){
        self.coordinatorDelegate = delegate
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: initialRoute)
    }
    
    init(delegate: AuthenticationCoordinatorDelegate){
        self.coordinatorDelegate = delegate
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: .distributorSignup)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .signin(let userType):
            let signInVC = SignInViewController(userType: userType)
            signInVC.delegate = self
            return .push(signInVC)
        case .distributorSignup:
            let disSignup = DistributorSignUpViewController()
            return .push(disSignup)
        case .companySignup:
            let signUpVC = CompanySignUpViewController()
            return .push(signUpVC)
        case .resellerSignup:
            let signUpVC = ResellerSignUpViewController()
            return .push(signUpVC)
        }
    }
}
 

extension AuthenticationCoordinator: SignInViewControllerDelegate {
    func signInViewController(_ sender: SignInViewController, didLoginWith profile: AuthUserProfile) {
        self.coordinatorDelegate?.authenticationCoordinator(self, didFinishWith: profile)
    }
}
