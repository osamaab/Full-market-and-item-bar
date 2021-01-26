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
    case signin
    case distributorSignup
    case companySignup
    case resellerSignup
}

/**
 So the clients don't wanna really care about how the authentication flow "internally" works, right now, the implementation does things with storyboards and xib's, and that's againest our guidelines for doing things, but this should not affect other parts of the app.
 */
class AuthenticationCoordinator: NavigationCoordinator<AuthenticationRoute> {
    
    init(initialRoute: AuthenticationRoute){
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: initialRoute)
    }
    
    init(){
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: .distributorSignup)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .signin:
            let signInVC = SignInViewController()
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
 
