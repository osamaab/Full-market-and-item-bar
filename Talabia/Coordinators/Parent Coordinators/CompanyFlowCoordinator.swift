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
    case items
}

class CompanyFlowCoordinator: TabBarCoordinator<CompanyFlowRoute> {
    let marketRouter: StrongRouter<MarketRoute>
    let cartRouter: StrongRouter<CartRoute>

    let profileRouter: StrongRouter<CompanyProfileRoute>
    let itemsRouter: StrongRouter<ItemsRoute>
    let distributorsRouter: StrongRouter<DistributorsRoute>
    let operationsRouter: StrongRouter<OperationsRoute>
            
    init(){
        self.marketRouter = MarketCoordinator().strongRouter
        self.profileRouter = CompanyProfileCoordinator().strongRouter
        self.itemsRouter = ItemsCoordinator().strongRouter
        self.distributorsRouter = DistributorsCoordinator().strongRouter
        self.operationsRouter = OperationsCoordinator().strongRouter
        
        self.cartRouter = CartCoordiantor().strongRouter
        
        super.init(rootViewController: TabBarController(), tabs: [marketRouter, operationsRouter, itemsRouter, distributorsRouter, profileRouter], select: 5)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .market:
            return .select(marketRouter)
        case .profile:
            return .select(profileRouter)
        case .items:
            return .select(itemsRouter)
        }
    }
}
