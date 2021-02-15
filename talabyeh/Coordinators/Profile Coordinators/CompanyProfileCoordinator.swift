//
//  ProfileCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum CompanyProfileRoute: Route {
    case profile
    case branches
    case editCategories
    
}

class CompanyProfileCoordinator: NavigationCoordinator<CompanyProfileRoute> {
        
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
            let profile = CompanyProfileViewController(router: self.unownedRouter)
            return .push(profile)
        case .branches:
            guard let profile = authenticationManager.authProfile, let asCompany = profile.associatedData as? Company else {
                AppDelegate.shared.router.trigger(.authentication(.signin(.company)))
                return .none()
            }
            
            let router = CompanyBranchesCoordinator(company: asCompany)
            return .presentFullScreen(router)
        case .editCategories:
            let coordinator = SubCategoriesPickerCoordinator(initialRoute: .new(.company), delegate: self)
            self.editCategoriesRouter = coordinator.strongRouter
            
            return .presentFullScreen(coordinator)
        }
    }
}

extension CompanyProfileCoordinator: SubCategoriesPickerCoordinatorDelegate {
    func subCategoriesPickerCoordinator(_ sender: SubCategoriesPickerCoordinator, didFinishWith categories: [SubCategory]) {
        
        
        // perform an api request to edit the categories
    }
}


