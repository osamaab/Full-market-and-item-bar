//
//  UITabBar+DefaultIcons.swift
//  talabyeh
//
//  Created by Hussein Work on 25/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit


extension UITabBarItem {
    
    static let companyProfile: UITabBarItem = .init(title: "Profile", image: UIImage(named: "Profile UP"), selectedImage: UIImage(named: "Profile DOWN"))
    
    static let profile: UITabBarItem = .init(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile-selected"))
    
    static let market: UITabBarItem = .init(title: "Market", image: UIImage(named: "market"), selectedImage: UIImage(named: "market-selected"))
    
    static let favorites: UITabBarItem = .init(title: "Favorites", image: UIImage(named: "favorites"), selectedImage: UIImage(named: "favorites-selected"))

    
    static let items: UITabBarItem = .init(title: "Items", image: UIImage(named: "items"), selectedImage: UIImage(named: "items-selected"))
    
    static let distributors: UITabBarItem = .init(title: "Distributors", image: UIImage(named: "Dis. UP"), selectedImage: UIImage(named: "Dis. DOWN"))

    static let operation: UITabBarItem = .init(title: "Operation", image: UIImage(named: "operations"), selectedImage: UIImage(named: "operations-selected"))

    static let talabia: UITabBarItem = .init(title: "Talabia", image: UIImage(named: "talabia"), selectedImage: UIImage(named: "talabia-selected"))
    
    static let cart: UITabBarItem = .init(title: "My cart", image: UIImage(named: "cart"), selectedImage: UIImage(named: "cart-selected"))

}
