//
//  AuthenticationCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import Promises
import Moya

enum AuthenticationRoute: Route {
    case signin
    case signup(UserType, [MainCategory],[SubCategory])
    
    
    case distributorSignup
    case companySignup([MainCategory],[SubCategory])
    case resellerSignup([MainCategory],[SubCategory])
    
    case chooseCategories(UserType, SubCategoriesPickerCoordinatorDelegate)
}

protocol AuthenticationCoordinatorDelegate: class {
    func authenticationCoordinator(_ sender: AuthenticationCoordinator, didFinishWith profile: AuthUserProfile)
}

/**
 So the clients don't wanna really care about how the authentication flow "internally" works, right now, the implementation does things with storyboards and xib's, and that's againest our guidelines for doing things, but this should not affect other parts of the app.
 */
class AuthenticationCoordinator: NavigationCoordinator<AuthenticationRoute> {
    fileprivate var currentFlowCoordinator: Presentable?
    weak var coordinatorDelegate: AuthenticationCoordinatorDelegate?
    
    init(delegate: AuthenticationCoordinatorDelegate, initialRoute: AuthenticationRoute){
        self.coordinatorDelegate = delegate
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: initialRoute)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .signin:
            let signInVC = SignInViewController()
            signInVC.delegate = self
            return .push(signInVC)
        case .signup(let userType, let categories, let subCategory):
            switch userType {
            case .company:
                return .trigger(.companySignup(categories, subCategory), on: self)
            case .distributor:
                return .trigger(.distributorSignup, on: self)
            case .reseller:
                return .trigger(.resellerSignup(categories, subCategory), on: self)
            }
        case .distributorSignup:
            let disSignup = DistributorSignUpViewController()
            disSignup.delegate = self
            return .push(disSignup)
        case .companySignup(let categories, let subCategory):
            let signUpVC = CompanySignUpViewController(categories: categories, subCategories: subCategory)
            signUpVC.delegate = self
            return .push(signUpVC)
        case .resellerSignup(let categories, let subCategory):
            let signUpVC = ResellerSignUpViewController(categories: categories, subCategories: subCategory)
            signUpVC.delegate = self
            return .push(signUpVC)
        case .chooseCategories(let userType, let delegate):
            let coordinator = SubCategoriesPickerCoordinator(initialRoute: .new(userType), delegate: delegate)
            return .presentFullScreen(coordinator)
        }
    }
}
 

extension AuthenticationCoordinator: SignInViewControllerDelegate {
    func signInViewController(_ sender: SignInViewController, didLoginWith profile: SignInViewController.Output) {
        
        sender.performTask(taskOperation: performLogin(with: profile.username, password: profile.password)).then { [unowned self] profile in
            self.coordinatorDelegate?.authenticationCoordinator(self, didFinishWith: profile)
        }
    }
    
    func performLogin(with username: String, password: String) -> Promise<AuthUserProfile> {
        return AuthenticationAPI.login(username, password).request(AuthUserProfile.self)
    }
}

extension AuthenticationCoordinator: ResellerSignUpViewControllerDelegate {
    func resellerSignUpViewController(sender: ResellerSignUpViewController, didFinishWith reseller: RegisterationForm.Reseller) {
        
        sender.performTask(taskOperation: AuthenticationAPI.resellerRegister(reseller).request(Reseller.self)).then { [unowned self] reseller in

            self.coordinatorDelegate?.authenticationCoordinator(self, didFinishWith: .reseller(reseller))
        }
    }
}

extension AuthenticationCoordinator: DistributorSignUpViewControllerDelegate {
    func distributorSignUpViewController(_ sender: DistributorSignUpViewController, didFinishWith distributor: RegisterationForm.Distributor) {
        
        sender.performTask(taskOperation: AuthenticationAPI.distributorRegister(distributor).request(Distributor.self)).then { [unowned self] distributor in
            
            self.coordinatorDelegate?.authenticationCoordinator(self, didFinishWith: .distributor(distributor))
        }
    }
}

extension AuthenticationCoordinator: CompanySignUpViewControllerDelegate {
    func companySignUpViewController(_ sender: CompanySignUpViewController, didFinishWith company: RegisterationForm.Company) {
        
        let route = AuthenticationAPI.companyRegister(company)
        sender.performTask(taskOperation: route.request(Company.self)).then {  [unowned self] company in
            self.coordinatorDelegate?.authenticationCoordinator(self, didFinishWith: .company(company))
        }
    }
}
