//
//  DistributorSignUpViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/21/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class DistributorSignUpViewController: UIViewController {
    
    let distributorSignUpView = DistributorSignUpView()
    
    
    override func loadView() {
        view = distributorSignUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        distributorSignUpView.distributorType = .PersonalDistributor
        distributorSignUpView.headerImage.image = LanguageManager.shared.currentLanguage == .en ? UIImage(named: "DistributorImageEnglish") : UIImage(named: "DistributorImageArabic")
        distributorSignUpView.backButton.addTarget(self, action: #selector(backButton), for: .touchUpInside)
    }
    
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
    }
}
