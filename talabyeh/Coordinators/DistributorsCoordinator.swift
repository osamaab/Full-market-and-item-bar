//
//  DistributorsCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 02/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

enum DistributorsRoute: Route {
    case home
}

class DistributorsCoordinator: NavigationCoordinator<DistributorsRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .home)
        rootViewController.tabBarItem = .distributors
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .home:
            let viewController = DistributersListViewController()
            return .push(viewController)
        }
    }
}
