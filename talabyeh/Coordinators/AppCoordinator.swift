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
}

class AppCoordinator: NavigationCoordinator<AppRoutes> {
    
    init(){
        super.init(rootViewController: NavigationController(autoShowsCloseButton: false), initialRoute: .lab)
        rootViewController.view.backgroundColor = DefaultColorsProvider.backgroundPrimary
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .chooseUserType:
            return .multiple(
                .dismissToRoot(animation: .fadeInstant),
                .presentFullScreen(viewController, animation: .fadeInstant)
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
        }
    }
}

