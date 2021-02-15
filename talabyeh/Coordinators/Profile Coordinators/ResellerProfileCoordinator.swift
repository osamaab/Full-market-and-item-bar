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
}

class ResellerProfileCoordinator: NavigationCoordinator<ResellerProfileRoute> {
        
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .profile)
        rootViewController.tabBarItem = .profile
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .profile:
            let profile = ResellerProfileViewController(router: self.unownedRouter)
            return .push(profile)
        }
    }
}
