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
}

/**
 So the clients don't wanna really care about how the authentication flow "internally" works, right now, the implementation does things with storyboards and xib's, and that's againest our guidelines for doing things, but this should not affect other parts of the app.
 */
class AuthenticationCoordinator: NavigationCoordinator<AuthenticationRoute> {
    
    
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .signin)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .signin:
            let signInVC = SignInViewController()
            return .push(signInVC)
        }
    }
}
 
