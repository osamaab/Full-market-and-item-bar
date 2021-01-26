//
//  TabBarController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBar.isTranslucent = false
        tabBar.barTintColor = DefaultColorsProvider.backgroundPrimary
        tabBar.backgroundImage = .init()
        tabBar.shadowImage = UIImage()
        tabBar.tintColor = DefaultColorsProvider.tintPrimary
        tabBar.unselectedItemTintColor = DefaultColorsProvider.elementUnselected
    }
}
