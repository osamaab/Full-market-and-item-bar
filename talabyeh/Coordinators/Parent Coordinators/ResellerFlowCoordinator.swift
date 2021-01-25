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
    case market
//    case cart
    case operations
    case items
    case profile
}

class ResellerFlowCoordinator: TabBarCoordinator<CompanyFlowRoute> {
    
    let marketRouter: StrongRouter<MarketRoute>
    let operationsRouter: StrongRouter<OperationsRoute>
    let itemsRouter: StrongRouter<ItemsRoute>
    let profileRouter: StrongRouter<ProfileRoute>

    init(){
        self.marketRouter = MarketCoordinator().strongRouter
        self.operationsRouter = OperationsCoordinator().strongRouter
        self.itemsRouter = ItemsCoordinator().strongRouter
        self.profileRouter = ProfileCoordinator().strongRouter

        super.init(rootViewController: TabBarController(), tabs: [itemsRouter], select: 0)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .market:
            return .select(marketRouter)
        case .profile:
            return .select(profileRouter)
        }
    }
}
