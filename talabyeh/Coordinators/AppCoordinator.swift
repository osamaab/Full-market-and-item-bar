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
    case company
    case lab
    case authentication(StrongRouter<AuthenticationRoute>?)
}

class AppCoordinator: NavigationCoordinator<AppRoutes> {
    
    init(){
        super.init(rootViewController: NavigationController(autoShowsCloseButton: false), initialRoute: .chooseUserType)
        rootViewController.view.backgroundColor = DefaultColorsProvider.backgroundPrimary
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .chooseUserType:
            let chooseUserViewController = ChooseUserViewController()
            
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(chooseUserViewController, animation: .fadeInstant)
            )
        case .lab:
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(ComponentsLabCoordinator(), animation: .fadeInstant)
            )
        case .company:
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(CompanyFlowCoordinator(), animation: .fadeInstant)
            )
        case .authentication(let router):
            let router = router ?? AuthenticationCoordinator().strongRouter
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(router, animation: .fadeInstant)
            )
        }
    }
}

