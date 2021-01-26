//
//  NavigationCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class NavigationCoordinator: CoordinatorType {
    
    let subCoordinator: CoordinatorType
    let navigationController: NavigationController
    
    var rootViewController: UIViewController {
        navigationController
    }
    
    init(coordinator: CoordinatorType){
        self.subCoordinator = coordinator
        self.navigationController = coordinator.rootViewController.embededInNavigationController()
    }
}

extension CoordinatorType {
    func embededInNavigationCoordinator() -> NavigationCoordinator {
        .init(coordinator: self)
    }
}
