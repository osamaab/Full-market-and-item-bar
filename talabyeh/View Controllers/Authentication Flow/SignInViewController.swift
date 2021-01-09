//
//  SignInViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class SignInViewController: UIViewController {
    
    let contentView = SignInContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            contentView
        }
        
        contentView.Top == view.safeAreaLayoutGuide.Top + 20
        contentView.leading(0).trailing(0)
    }
}
