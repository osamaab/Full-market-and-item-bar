//
//  ResellerOperationsCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 26/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

enum ResellerOperationsRoute: Route {
    case home
}

class ResellerOperationsCoordinator: NavigationCoordinator<ResellerOperationsRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .home)
        rootViewController.tabBarItem = .talabia
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .home:
            let viewController = ChooseUserViewController()
            return .push(viewController)
        }
    }
}
