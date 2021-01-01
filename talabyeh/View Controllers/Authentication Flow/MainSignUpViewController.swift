//
//  MainSignUpViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/6/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Stevia
import SDWebImage


class MainSignUpViewController: UIViewController {
    
    struct Actions {
        var onNext: ((UserTypeEnum) -> Void)?
    }

    @IBOutlet weak var companyView: RoundedView!
    @IBOutlet weak var distributorView: RoundedView!
    @IBOutlet weak var resellerView: RoundedView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var letsgetStartedLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var distributorLabel: UILabel!
    @IBOutlet weak var resellerLabel: UILabel!
    @IBOutlet weak var nextButton: RoundedButton!
    
    @IBOutlet weak var companyImage: UIImageView!
    
    @IBOutlet weak var distributorImage: UIImageView!
    @IBOutlet weak var resellerImage: UIImageView!
    
    @IBOutlet weak var lineView1: UIView!
    @IBOutlet weak var lineView2: UIView!
    @IBOutlet weak var lineView3: UIView!
    
    var chosenUserType: UserTypeEnum?
    var actions: Actions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineView1.backgroundColor = DefaultColorsProvider.tintPrimary
        lineView2.backgroundColor = DefaultColorsProvider.tintPrimary
        lineView3.backgroundColor = DefaultColorsProvider.tintPrimary
    }


    @IBAction func chooseMerchantType(_ sender: Any) {
        let tag = (sender as AnyObject).tag!
        if tag == 0{
            companyView.backgroundColor = DefaultColorsProvider.tintSecondary
            distributorView.backgroundColor = DefaultColorsProvider.containerBackground2
            resellerView.backgroundColor = DefaultColorsProvider.containerBackground2
            
            chosenUserType = .Company
        }else if tag == 1{
            distributorView.backgroundColor = DefaultColorsProvider.tintSecondary
            companyView.backgroundColor = DefaultColorsProvider.containerBackground2
            resellerView.backgroundColor = DefaultColorsProvider.containerBackground2
            
            chosenUserType = .Distributor
        }else if tag == 2{
            resellerView.backgroundColor = DefaultColorsProvider.tintSecondary
            distributorView.backgroundColor = DefaultColorsProvider.containerBackground2
            companyView.backgroundColor = DefaultColorsProvider.containerBackground2
            
            chosenUserType = .Reseller
        }
        
        nextButton.isEnabled = true
    }
    
    @IBAction func next(_ sender: Any) {
        guard let userType = self.chosenUserType else {
            return
        }
        
        self.actions?.onNext?(userType)
    }
}

enum UserTypeEnum {
    case Company
    case Distributor
    case Reseller
}
