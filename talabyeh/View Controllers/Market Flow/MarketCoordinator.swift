//
//  MarketCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit


class MarketCoordinator: TabBarSubCoordinator {
    
    var rootViewController: UIViewController? {
        navigationController
    }
    
    var tabBarItem: UITabBarItem! {
        .init(title: "Market", image: UIImage(named: "market-selected"), selectedImage: UIImage(named: "market-selected"))
    }
    
    let navigationController: NavigationController
    let marketViewController: MarketViewController
    
    init(){
        self.marketViewController = .init()
        self.navigationController = marketViewController.embededInNavigationController()
    }
    
    func start() {
        
    }
}
