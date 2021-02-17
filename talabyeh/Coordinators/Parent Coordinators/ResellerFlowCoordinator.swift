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
}

class ResellerFlowCoordinator: TabBarCoordinator<ResellerFlowRoute> {
    
    let profileRouter: StrongRouter<ResellerProfileRoute>
    let favoritesRouter: StrongRouter<FavoritesRoute>

    init(){
        self.profileRouter = ResellerProfileCoordinator().strongRouter
        self.favoritesRouter = FavoritesCoordinator().strongRouter

        super.init(rootViewController: TabBarController(), tabs: [favoritesRouter, profileRouter], select: 0)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .profile:
            return .select(profileRouter)
        case .favorites:
            return .select(favoritesRouter)
        }
    }
}
