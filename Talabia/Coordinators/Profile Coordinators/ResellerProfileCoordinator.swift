//
//  ResellerProfileCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

enum ResellerProfileRoute: Route {
    case notLogin
    case profile
    case editProfile
    case storeLocations
    case editCategories
    case changePassword
}

class ResellerProfileCoordinator: NavigationCoordinator<ResellerProfileRoute> {
    
    let preferencesManager = UserDefaultsPreferencesManager.shared
    let authenticationManager = DefaultAuthenticationManager.shared
    
    fileprivate var editCategoriesRouter: StrongRouter<SubCategoriesPickerRoute>?
        
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
            let profile = ResellerProfileViewController(router: self.unownedRouter)
            profile.title = "Profile"
            return .push(profile)
        case .editProfile:
            guard let reseller = DefaultAuthenticationManager.shared.authProfile?.associatedData as? Reseller else {
                return .none()
            }
            
            let router = EditProfileCoordinator(initialRoute: .resellerEditProfile(reseller))
            return .presentFullScreen(router)
        case .storeLocations:
            guard let profile = authenticationManager.authProfile, let asReseller = profile.associatedData as? Reseller else {
                AppDelegate.shared.router.trigger(.authentication(.signin))
                return .none()
            }
            
            let router = ResellerStoreLocationsCoordinator(reseller: asReseller)
            return .presentFullScreen(router)
        case .editCategories:
            let coordinator = SubCategoriesPickerCoordinator(initialRoute: .new(.reseller), delegate: self)
            self.editCategoriesRouter = coordinator.strongRouter
            
            return .presentFullScreen(coordinator)
        case .changePassword:
            let router = ChangePasswordCoordinator()
            return .presentFullScreen(router)
        }
    }
}

extension ResellerProfileCoordinator: SubCategoriesPickerCoordinatorDelegate {
    func chooseUserCoordinatorDidChooseSkip(_ sender: SubCategoriesPickerCoordinator) {
    }
    
    func subCategoriesPickerCoordinator(_ sender: SubCategoriesPickerCoordinator, didFinishWith categories: [SubCategory]) {
        
        
        // perform an api request to edit the categories
    }
}



