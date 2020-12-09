//
//  NewPaymentCreditCardViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 09/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class NewPaymentCreditCardViewController: UIViewController {

    let contentView: NewPaymentCreditCardContentView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.background1
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(contentView)
        contentView.Top == view.safeAreaLayoutGuide.Top
        contentView.leading(0).trailing(0)
    }
}
