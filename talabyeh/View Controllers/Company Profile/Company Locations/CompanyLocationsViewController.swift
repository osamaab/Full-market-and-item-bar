//
//  CompanyLocationsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 16/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompanyLocationsViewController: UIViewController {

    let contentView = CompanyLocationsContentView()
    let saveButtonView = BottomNextButtonView(title: "Save")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hidesBottomBarWhenPushed = true
        view.backgroundColor = DefaultColorsProvider.background
        
        view.subviewsPreparedAL {
            contentView
            saveButtonView
        }
        
        contentView.leading(0).trailing(0)
        contentView.Top == view.safeAreaLayoutGuide.Top + 30
        contentView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        saveButtonView.leading(0).trailing(0).bottom(0)
        
        contentView.collectionView.contentInset.bottom += 120
    }
}
