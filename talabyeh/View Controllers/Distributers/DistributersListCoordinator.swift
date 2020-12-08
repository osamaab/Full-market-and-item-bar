//
//  DistributersListCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 17/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class DistributersListCoordinator: TabBarSubCoordinator {
    
    var rootViewController: UIViewController {
        distributersListViewController
    }
    
    var tabBarItem: UITabBarItem! {
        .init(title: "Distributers", image: UIImage(named: "distributers"), selectedImage: UIImage(named: "distributers-selected"))
    }
    
    let distributersListViewController: DistributersListViewController
    
    init(){
        self.distributersListViewController = .init()
    }
}
