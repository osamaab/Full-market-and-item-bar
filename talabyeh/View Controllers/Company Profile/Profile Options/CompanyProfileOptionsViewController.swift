//
//  CompanyProfileOptionsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompanyProfileOptionsViewController: UIViewController {

    let saveButtonView = BottomNextButtonView(title: "Save")
    let contentView = ProfileOptionsContentView(options: [
        "Upload PDF",
        "Create New",
        "Contact Our designers"
    ])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            contentView
            saveButtonView
        }
        
        contentView.leading(20).trailing(20)
        contentView.Top == view.safeAreaLayoutGuide.Top + 30
        
        saveButtonView.leading(0).trailing(0).bottom(0)
    }
}
