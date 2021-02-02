//
//  ItemsCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 02/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum ItemsRoute: Route {
    case home
}

class ItemsCoordinator: NavigationCoordinator<ItemsRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .home)
        rootViewController.tabBarItem = .items
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .home:
            let viewController = ItemsViewController(contentRepository: ItemsViewController.SampleContentProvider())
            return .push(viewController)
        }
    }
}
