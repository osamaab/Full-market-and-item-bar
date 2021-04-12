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
    case favorites
    case cart
    case talabia
}

class ResellerFlowCoordinator: TabBarCoordinator<ResellerFlowRoute> {
    
    let marketRouter: StrongRouter<MarketRoute>
    let cartRouter: StrongRouter<CartRoute>
    let operationsRouter: StrongRouter<ResellerOperationsRoute>
    let profileRouter: StrongRouter<ResellerProfileRoute>
    let favoritesRouter: StrongRouter<FavoritesRoute>
    let talabiaRouter: StrongRouter<TalabiaRoute>

    init(){
        self.cartRouter = CartCoordiantor().strongRouter
        self.marketRouter = MarketCoordinator().strongRouter
        self.operationsRouter = ResellerOperationsCoordinator().strongRouter
        self.profileRouter = ResellerProfileCoordinator().strongRouter
        self.favoritesRouter = FavoritesCoordinator().strongRouter
        self.talabiaRouter = TalabiaCoordinator().strongRouter

        super.init(rootViewController: TabBarController(), tabs: [marketRouter, cartRouter,talabiaRouter, favoritesRouter, profileRouter], select: 0)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .profile:
            return .select(profileRouter)
        case .favorites:
            return .select(favoritesRouter)
        case .cart:
            return .select(cartRouter)
        case .talabia:
        return .select(talabiaRouter)
        }
    }
}
