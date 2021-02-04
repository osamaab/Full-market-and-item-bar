//
//  CompanyFlowCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 28/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum CompanyFlowRoute: Route {
    case market
    case profile
}

class CompanyFlowCoordinator: TabBarCoordinator<CompanyFlowRoute> {
    
    let marketRouter: StrongRouter<MarketRoute>
    let profileRouter: StrongRouter<ProfileRoute>
    let itemsRouter: StrongRouter<ItemsRoute>
    let distributorsRouter: StrongRouter<DistributorsRoute>
    let operationsRouter: StrongRouter<OperationsRoute>
        
    init(){
        self.marketRouter = MarketCoordinator().strongRouter
        self.profileRouter = ProfileCoordinator().strongRouter
        self.itemsRouter = ItemsCoordinator().strongRouter
        self.distributorsRouter = DistributorsCoordinator().strongRouter
        self.operationsRouter = OperationsCoordinator().strongRouter
        
        super.init(rootViewController: TabBarController(), tabs: [itemsRouter, profileRouter], select: 0)
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
