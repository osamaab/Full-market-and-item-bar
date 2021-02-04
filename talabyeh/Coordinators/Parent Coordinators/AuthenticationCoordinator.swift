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
    case signUp(UserType)
    
    
    case distributorSignup
    case companySignup
    case resellerSignup
    
    case chooseCategories(UserType, SubCategoriesPickerCoordinatorDelegate)
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
        case .signUp(let userType):
            switch userType {
            case .company:
                return .trigger(.companySignup, on: self)
            case .distributor:
                return .trigger(.distributorSignup, on: self)
            case .reseller:
                return .trigger(.resellerSignup, on: self)
            }
        case .distributorSignup:
            let disSignup = DistributorSignUpViewController()
            disSignup.delegate = self
            return .push(disSignup)
        case .companySignup:
            let signUpVC = CompanySignUpViewController(router: self.unownedRouter)
            signUpVC.delegate = self
            return .push(signUpVC)
        case .resellerSignup:
            let signUpVC = ResellerSignUpViewController(router: self.unownedRouter)
            signUpVC.delegate = self
            return .push(signUpVC)
        case .chooseCategories(let userType, let delegate):
            let coordinator = SubCategoriesPickerCoordinator(initialRoute: .new(userType), delegate: delegate)
            return .presentFullScreen(coordinator)
        }
    }
}
 

extension AuthenticationCoordinator: SignInViewControllerDelegate {
    func signInViewController(_ sender: SignInViewController, didLoginWith profile: AuthUserProfile) {
        DefaultAuthenticationManager.shared.login(with: profile)
        self.coordinatorDelegate?.authenticationCoordinator(self, didFinishWith: profile)
    }
}

extension AuthenticationCoordinator: ResellerSignUpViewControllerDelegate {
    func resellerSignUpViewController(sender: ResellerSignUpViewController, didFinishWith reseller: Reseller) {
        DefaultAuthenticationManager.shared.login(with: .reseller(reseller))
        self.coordinatorDelegate?.authenticationCoordinator(self, didFinishWith: .reseller(reseller))
    }
}

extension AuthenticationCoordinator: DistributorSignUpViewControllerDelegate {
    func distributorSignUpViewController(_ sender: DistributorSignUpViewController, didFinishWith distributor: Distributor) {
        DefaultAuthenticationManager.shared.login(with: .distributor(distributor))
        self.coordinatorDelegate?.authenticationCoordinator(self, didFinishWith: .distributor(distributor))
    }
}

extension AuthenticationCoordinator: CompanySignUpViewControllerDelegate {
    func companySignUpViewController(_ sender: CompanySignUpViewController, didFinishWith company: Company) {
        DefaultAuthenticationManager.shared.login(with: .company(company))
        self.coordinatorDelegate?.authenticationCoordinator(self, didFinishWith: .company(company))
    }
}
