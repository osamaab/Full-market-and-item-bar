//
//  FavoritesCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 22/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit


class FavoritesCoordinator: TabBarSubCoordinator {
    
    var rootViewController: UIViewController {
        favoritesViewController
    }
    
    var tabBarItem: UITabBarItem! {
        .init(title: "Favorites", image: UIImage(named: "favorites"), selectedImage: nil)
    }
    
    let favoritesViewController: FavoritesViewController
    
    init(){
        self.favoritesViewController = .init()
    }
}

