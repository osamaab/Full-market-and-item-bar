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
        // doing dummy data here :)
        let headerInfo = ProfileHeaderInfo(title: "Hussein AlRyalat",
                                           imageURL: nil,
                                           subtitle: "hus.sc@aol.com",
                                           subtitle2: nil)
        
        let menuItems = [
            ProfileMenuItem.changePassword(),
            .payment(),
            .orders(),
            .location(),
            .information(),
            .history()
        ]
        
        self.profileViewController = ProfilePageViewController(headerInfo: headerInfo, menuItems: menuItems)
        self.navigationController = profileViewController.embededInNavigationController()
    }
    
    func start() {
        
    }
}
