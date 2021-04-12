//
//  AllItemsCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 08/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class AllItemsCoordinator: ItemsCoordinator {
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .userCategories:
            let viewController = ItemCategoriesViewController(router: self.unownedRouter)
            return .push(viewController as! Presentable)
        case .items(let subcategory):
            let viewController = ItemsViewController(router: self.unownedRouter, category: subcategory, api: .myProducts)
            viewController.allowsEditing = false
            return .push(viewController)
        default:
            return super.prepareTransition(for: route)
        }
    }
}
