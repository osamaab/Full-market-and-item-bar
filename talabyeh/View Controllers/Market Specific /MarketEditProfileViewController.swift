//
//  MarketEditProfileViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 23/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class MarketEditProfileViewController: UIViewController {
    
    let contentView = MarketEditProfileContentView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.background1
        
        view.subviewsPreparedAL { () -> [UIView] in
            contentView
        }
        
        contentView.Top == view.safeAreaLayoutGuide.Top + 20
        contentView.leading(20).trailing(20)
    }
}
