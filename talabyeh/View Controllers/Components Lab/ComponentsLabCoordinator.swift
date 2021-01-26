//
//  ComponentsLabCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 01/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ComponentsLabCoordinator: NSObject, TabBarSubCoordinator {

   fileprivate(set) var rootViewController: UIViewController
    
    var tabBarItem: UITabBarItem! {
        .init(title: "Lab", image: UIImage(systemName: "flame"), selectedImage: UIImage(named: "flame.fill"))
    }
    
    override init(){
        rootViewController = CLLabViewController()
        super.init()
    }
}
