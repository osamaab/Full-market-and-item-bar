//
//  OperationsCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 02/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum OperationsRoute: Route {
    case home
}

class OperationsCoordinator: NavigationCoordinator<OperationsRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .home)
        rootViewController.tabBarItem = .operations
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .home:
            let viewController = OprationsListViewController()
            return .push(viewController)
        }
    }
}
