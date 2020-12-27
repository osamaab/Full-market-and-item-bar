//
//  CertificatesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 14/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CertificatesViewController: UIViewController {
    
    let contentView = CertificatesContentView()
    let saveButtonView = BottomNextButtonView(title: "Save")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hidesBottomBarWhenPushed = true
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            contentView
            saveButtonView
        }
        
        contentView.leading(20).trailing(20)
        contentView.Top == view.safeAreaLayoutGuide.Top + 30
        contentView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        saveButtonView.leading(0).trailing(0).bottom(0)
        
        contentView.collectionView.contentInset.bottom += 120
    }
}
