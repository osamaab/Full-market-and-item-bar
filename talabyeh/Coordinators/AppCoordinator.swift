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
    case authentication(AuthenticationRoute)
}

class AppCoordinator: NavigationCoordinator<AppRoutes> {
    
    init(){
        super.init(rootViewController: NavigationController(autoShowsCloseButton: false), initialRoute: .lab)
        rootViewController.view.backgroundColor = DefaultColorsProvider.backgroundPrimary
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .chooseUserType:
            let chooseUserViewController = ChooseUserViewController()
            chooseUserViewController.delegate = self
            
            return .push(chooseUserViewController)
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
        case .authentication(let route):
            let router = AuthenticationCoordinator(initialRoute: route).strongRouter
            return .presentFullScreen(router, animation: .fadeInstant)
        }
    }
}



extension AppCoordinator: ChooseUserViewControllerDelegate {
    func chooseUserViewController(_ sender: ChooseUserViewController, didFinishWith user: APIUserType) {
        switch user.id {
        case 1:
            self.trigger(.authentication(.companySignup))
        case 2:
            self.trigger(.authentication(.distributorSignup))
            break
        default:
            self.trigger(.authentication(.resellerSignup))
            break
        }
    }
}
