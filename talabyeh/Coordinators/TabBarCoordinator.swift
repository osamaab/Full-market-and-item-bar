//
//  TabBarCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

/**
 A coordinator which can be putted inside a tab bar controller
 */
protocol TabBarSubCoordinator: CoordinatorType {
    var tabBarItem: UITabBarItem! { get }
}

class TabBarCoordinator: CoordinatorType {
    
    let coordinators: [TabBarSubCoordinator]
    let tabBarController = TabBarController()
    
    
    var rootViewController: UIViewController? {
        tabBarController
    }
    
    init(coordinators: [TabBarSubCoordinator]){
        self.coordinators = coordinators
        
        let viewControllers: [UIViewController] = coordinators.compactMap {
            $0.rootViewController?.tabBarItem = $0.tabBarItem
            return $0.rootViewController
        }
        
        tabBarController.viewControllers = viewControllers
    }
    
    func start() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = self.rootViewController
        appDelegate.window?.makeKeyAndVisible()
    }
}