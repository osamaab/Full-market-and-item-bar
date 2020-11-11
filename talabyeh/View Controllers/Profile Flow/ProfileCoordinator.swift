//
//  ProfileCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

class ProfileCoordinator: TabBarSubCoordinator {
    
    var rootViewController: UIViewController? {
        navigationController
    }
    
    var tabBarItem: UITabBarItem! {
        .init(title: "Profile", image: UIImage(named: "profile"), selectedImage: nil)
    }
    
    let navigationController: NavigationController
    let profileViewController: ProfilePageViewController
    
    init(){
        self.profileViewController = .init()
        self.navigationController = profileViewController.embededInNavigationController()
    }
    
    func start() {
        
    }
}
