//
//  AppCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 28/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum AppRoutes: Route {
    case chooseUserType
    case lab
    case authentication(AuthenticationRoute)

    case company
    case distributor
    case reseller
    
    static func route(for userType: UserType) -> AppRoutes {
        switch userType {
        case .company:
            return .company
        case .distributor:
            return .distributor
        case .reseller:
            return .reseller
        }
    }
}

class AppCoordinator: NavigationCoordinator<AppRoutes> {
    
    let preferencesManager = UserDefaultsPreferencesManager.shared
    
    init(){
        // where we want to go? this can be determinated by the user type, if it exists anyway.
        let root = NavigationController(autoShowsCloseButton: false)
        
        guard let userType = preferencesManager.userType else {
            super.init(rootViewController: root, initialRoute: .chooseUserType)
            return
        }
        
        super.init(rootViewController: root, initialRoute: AppRoutes.route(for: userType))
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .chooseUserType:
            let coordinator = ChoooseUserCoordinator(delegate: self)
            
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(coordinator, animation: .fadeInstant))
            
        case .lab:
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(ComponentsLabCoordinator(), animation: .fadeInstant))
            
        case .company:
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(CompanyFlowCoordinator(), animation: .fadeInstant))
        case .distributor:
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(CompanyFlowCoordinator(), animation: .fadeInstant))
        case .reseller:
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(CompanyFlowCoordinator(), animation: .fadeInstant))
            
        case .authentication(let route):
            let router = AuthenticationCoordinator(delegate: self, initialRoute: route).strongRouter
            return .presentFullScreen(router, animation: .modal)
        }
    }
}

extension AppCoordinator: ChooseUserCoordinatorDelegate {
    func chooseUserCoordinator(_ sender: ChoooseUserCoordinator, didFinishWith output: ChoooseUserCoordinator.Output) {
        
        DefaultPreferencesController.shared.userType = output.userType
        DefaultPreferencesController.shared.selectedCategories = output.categories
        DefaultPreferencesController.shared.selectedSubCategories = output.subCategories
        
        
        self.trigger(.route(for: output.userType))
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinator(_ sender: AuthenticationCoordinator, didFinishWith profile: AuthUserProfile) {        
        self.trigger(.route(for: profile.userType))
    }
}
