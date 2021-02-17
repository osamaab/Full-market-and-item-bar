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
    case profile
    case storeLocations
    case editCategories
    case changePassword
}

class ResellerProfileCoordinator: NavigationCoordinator<ResellerProfileRoute> {
    
    let preferencesManager = UserDefaultsPreferencesManager.shared
    let authenticationManager = DefaultAuthenticationManager.shared
    
    fileprivate var editCategoriesRouter: StrongRouter<SubCategoriesPickerRoute>?
        
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .profile)
        rootViewController.tabBarItem = .profile
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .profile:
            let profile = ResellerProfileViewController(router: self.unownedRouter)
            return .push(profile)
        case .storeLocations:
            guard let profile = authenticationManager.authProfile, let asReseller = profile.associatedData as? Reseller else {
                AppDelegate.shared.router.trigger(.authentication(.signin(.reseller)))
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
    func subCategoriesPickerCoordinator(_ sender: SubCategoriesPickerCoordinator, didFinishWith categories: [SubCategory]) {
        
        
        // perform an api request to edit the categories
    }
}



