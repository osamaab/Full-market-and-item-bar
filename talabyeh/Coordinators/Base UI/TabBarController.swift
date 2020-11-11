//
//  TabBarController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.backgroundImage = .init()
        tabBar.shadowImage = UIImage()
        tabBar.tintColor = DefaultColorsProvider.darkTint
    }
}
