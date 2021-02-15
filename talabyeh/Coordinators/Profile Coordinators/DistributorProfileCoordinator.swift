//
//  DistributorProfileCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

enum DistributorProfileRoute: Route {
    case profile
}

class DistributorProfileCoordinator: NavigationCoordinator<DistributorProfileRoute> {
        
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .profile)
        rootViewController.tabBarItem = .profile
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .profile:
            let profile = DistributorProfileViewController(router: self.unownedRouter)
            return .push(profile)
        }
    }
}
