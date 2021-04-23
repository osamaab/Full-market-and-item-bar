//
//  DistributorFlowCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 25/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator


enum DistributorFlowRoute: Route {
    case profile
}

class DistributorFlowCoordinator: TabBarCoordinator<DistributorFlowRoute> {
    
    let profileRouter: StrongRouter<DistributorProfileRoute>
    let operationsRouter: StrongRouter<DistributorsOperationsRoute>
    let marketRouter: StrongRouter<MarketRoute>

    init(){
        self.profileRouter = DistributorProfileCoordinator().strongRouter
        self.operationsRouter = DistributorsOperationsCoordinator().strongRouter
        self.marketRouter = MarketCoordinator().strongRouter

        super.init(rootViewController: TabBarController(), tabs: [marketRouter, operationsRouter, profileRouter], select: 0)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .profile:
            return .select(profileRouter)
        }
    }
}
