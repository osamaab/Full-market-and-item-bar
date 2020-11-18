//
//  TestLabCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 18/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class TestLabCoordinator: TabBarSubCoordinator {
    
    fileprivate(set) var rootViewController: UIViewController?
    
    var tabBarItem: UITabBarItem! {
        .init(title: "Lab", image: UIImage(named: "items"), selectedImage: nil)
    }
        
    init(){
        self.rootViewController = TestLabViewController()
    }
}
