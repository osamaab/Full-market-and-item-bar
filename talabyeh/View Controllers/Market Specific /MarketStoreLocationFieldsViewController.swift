//
//  MarketStoreLocationFieldsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 27/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class MarketStoreLocationFieldsViewController: UIViewController {

    let contentView = MarketStoreLocationFIeldsContentView()
    let confirmButton: CircleConfirmButton = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            contentView
            confirmButton
        }
        
        contentView.Top == view.safeAreaLayoutGuide.Top + 20
        contentView.leading(20).trailing(20)
        
        confirmButton.trailing(20)
        confirmButton.Top == contentView.Bottom + 20
    }
}
