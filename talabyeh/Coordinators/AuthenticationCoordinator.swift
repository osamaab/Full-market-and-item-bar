//
//  AuthenticationCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

protocol AuthenticationCoordinatorDelegate: class {
    func authenticationCoordinator(didFinishWith userType: UserTypeEnum)
}

enum AuthenticationRoute: Route {
    case home
}

/**
 So the clients don't wanna really care about how the authentication flow "internally" works, right now, the implementation does things with storyboards and xib's, and that's againest our guidelines for doing things, but this should not affect other parts of the app.
 */
class AuthenticationCoordinator: NavigationCoordinator<AuthenticationRoute> {
}
 
