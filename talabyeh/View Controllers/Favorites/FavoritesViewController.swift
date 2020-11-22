//
//  FavoritesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class FavoritesViewController: UIViewController {
    
    let segmentedControl = BigSegmentedControl(items: ["Items", "Companies"])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.background1
     
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        
        segmentedControl.Top == view.safeAreaLayoutGuide.Top + 20
        segmentedControl.leading(20).trailing(20)
        segmentedControl.select(index: 0, animated: true)
    }
}
