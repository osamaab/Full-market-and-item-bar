//
//  MarketChangePasswordViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class MarketChangePasswordViewController: UIViewController {

    let contentView = MarketChangePasswordContentView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.subviewsPreparedAL { () -> [UIView] in
            contentView
        }
        
        contentView.Top == view.safeAreaLayoutGuide.Top
        contentView.leading(0).trailing(0)
    }
}
