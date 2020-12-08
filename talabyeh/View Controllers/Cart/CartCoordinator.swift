//
//  CartCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 26/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class CartCoordinator: TabBarSubCoordinator {
    
    var rootViewController: UIViewController {
        cartViewController
    }
    
    var tabBarItem: UITabBarItem! {
        .init(title: "Cart", image: UIImage(named: "cart"), selectedImage: nil)
    }
    
    let cartViewController: CartItemsViewController
    
    init(){
        self.cartViewController = .init()
    }
}
