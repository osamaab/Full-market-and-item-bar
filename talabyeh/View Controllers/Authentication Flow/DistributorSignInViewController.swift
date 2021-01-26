//
//  DistributorSignInViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class DistributorSignInViewController: UIViewController {

    lazy var contentView = DistributorSignInContentView()
    lazy var bottomNextView: BottomNextButtonView = .init(title: "Save")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews(){
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            contentView
            bottomNextView
        }
        
        contentView.Top == view.safeAreaLayoutGuide.Top + 20
        contentView.leading(20).trailing(20)
        
        bottomNextView.leading(0).trailing(0).bottom(0)
    }
}
