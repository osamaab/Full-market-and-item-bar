//
//  ResellerFlowCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 25/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum ResellerFlowRoute: Route {
    case profile
}

class ResellerFlowCoordinator: TabBarCoordinator<ResellerFlowRoute> {
    
    let profileRouter: StrongRouter<ResellerProfileRoute>

    init(){
        self.profileRouter = ResellerProfileCoordinator().strongRouter

        super.init(rootViewController: TabBarController(), tabs: [profileRouter], select: 0)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .profile:
            return .select(profileRouter)
        }
    }
}
